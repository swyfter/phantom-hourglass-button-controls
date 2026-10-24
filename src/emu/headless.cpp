// Minimal headless melonDS runner: scripted input, screenshots, savestates, memory peeks.
#include <cstdio>
#include <cstdarg>
#include <cstring>
#include <string>
#include <fstream>
#include <sstream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>
#include <map>
#include <vector>
#include <png.h>
#include "NDS.h"
#include "NDSCart.h"
#include "Platform.h"
#include "Savestate.h"
#include "GPU_Soft.h"
#include "Args.h"

using namespace melonDS;
namespace melonDS { extern u32 g_wwatchAddr; extern u32 g_watchAddr; extern void (*g_watchCb)(u32,u32); }
#include <set>
static std::set<std::pair<u32,u32>> g_hits;
static void watchcb(u32 pc, u32 lr) { g_hits.insert({pc,lr}); }

namespace melonDS::Platform {
struct Thread { std::thread t; };
struct Semaphore { std::mutex m; std::condition_variable cv; int c=0; };
struct Mutex { std::mutex m; };
struct FileHandle;
static std::string savepath;
void SignalStop(StopReason, void*) {}
FileHandle* OpenFile(const std::string& path, FileMode mode) {
    std::string m;
    if (mode & FileMode::Read) m = (mode & FileMode::Write) ? ((mode & FileMode::Preserve) ? "r+b" : "w+b") : "rb";
    else if (mode & FileMode::Write) m = (mode & FileMode::Append) ? "ab" : "wb";
    else m = "rb";
    return (FileHandle*)fopen(path.c_str(), m.c_str());
}
std::string GetLocalFilePath(const std::string& f) { return f; }
FileHandle* OpenLocalFile(const std::string& p, FileMode m) { return OpenFile(p, m); }
bool CloseFile(FileHandle* f) { return fclose((FILE*)f)==0; }
bool IsEndOfFile(FileHandle* f) { return feof((FILE*)f); }
bool FileReadLine(char* s, int c, FileHandle* f) { return fgets(s, c, (FILE*)f); }
bool FileExists(const std::string& n) { FILE* f=fopen(n.c_str(),"rb"); if(f) fclose(f); return f; }
bool LocalFileExists(const std::string& n) { return FileExists(n); }
bool CheckFileWritable(const std::string&) { return true; }
bool CheckLocalFileWritable(const std::string&) { return true; }
bool FileSeek(FileHandle* f, s64 o, FileSeekOrigin org) { int w = org==FileSeekOrigin::Start?SEEK_SET:org==FileSeekOrigin::Current?SEEK_CUR:SEEK_END; return fseek((FILE*)f,o,w)==0; }
void FileRewind(FileHandle* f) { rewind((FILE*)f); }
u64 FilePosition(FileHandle* f) { return ftell((FILE*)f); }
u64 FileRead(void* d, u64 s, u64 c, FileHandle* f) { return fread(d,s,c,(FILE*)f); }
bool FileFlush(FileHandle* f) { return fflush((FILE*)f)==0; }
u64 FileWrite(const void* d, u64 s, u64 c, FileHandle* f) { return fwrite(d,s,c,(FILE*)f); }
u64 FileWriteFormatted(FileHandle* f, const char* fmt, ...) { va_list a; va_start(a,fmt); int r=vfprintf((FILE*)f,fmt,a); va_end(a); return r; }
u64 FileLength(FileHandle* f) { long p=ftell((FILE*)f); fseek((FILE*)f,0,SEEK_END); long l=ftell((FILE*)f); fseek((FILE*)f,p,SEEK_SET); return l; }
void Log(LogLevel level, const char* fmt, ...) { if (level < LogLevel::Warn) return; va_list a; va_start(a,fmt); vfprintf(stderr,fmt,a); va_end(a); }
Thread* Thread_Create(std::function<void()> fn) { auto t=new Thread; t->t=std::thread(fn); return t; }
void Thread_Free(Thread* t) { if(t->t.joinable()) t->t.detach(); delete t; }
void Thread_Wait(Thread* t) { if(t->t.joinable()) t->t.join(); }
Semaphore* Semaphore_Create() { return new Semaphore; }
void Semaphore_Free(Semaphore* s) { delete s; }
void Semaphore_Reset(Semaphore* s) { std::lock_guard l(s->m); s->c=0; }
void Semaphore_Wait(Semaphore* s) { std::unique_lock l(s->m); s->cv.wait(l,[&]{return s->c>0;}); s->c--; }
bool Semaphore_TryWait(Semaphore* s, int ms) { std::unique_lock l(s->m); if(!s->cv.wait_for(l,std::chrono::milliseconds(ms),[&]{return s->c>0;})) return false; s->c--; return true; }
void Semaphore_Post(Semaphore* s, int c) { { std::lock_guard l(s->m); s->c+=c; } s->cv.notify_all(); }
Mutex* Mutex_Create() { return new Mutex; }
void Mutex_Free(Mutex* m) { delete m; }
void Mutex_Lock(Mutex* m) { m->m.lock(); }
void Mutex_Unlock(Mutex* m) { m->m.unlock(); }
bool Mutex_TryLock(Mutex* m) { return m->m.try_lock(); }
void Sleep(u64 us) { std::this_thread::sleep_for(std::chrono::microseconds(us)); }
u64 GetMSCount() { return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
u64 GetUSCount() { return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
void WriteNDSSave(const u8* d, u32 len, u32, u32, void*) { if(savepath.empty()) return; FILE* f=fopen(savepath.c_str(),"wb"); if(f){fwrite(d,1,len,f);fclose(f);} }
void WriteGBASave(const u8*, u32, u32, u32, void*) {}
void WriteFirmware(const Firmware&, u32, u32, void*) {}
void WriteDateTime(int,int,int,int,int,int,void*) {}
void MP_Begin(void*) {} void MP_End(void*) {}
int MP_SendPacket(u8*, int, u64, void*) { return 0; }
int MP_RecvPacket(u8*, u64*, void*) { return 0; }
int MP_SendCmd(u8*, int, u64, void*) { return 0; }
int MP_SendReply(u8*, int, u64, u16, void*) { return 0; }
int MP_SendAck(u8*, int, u64, void*) { return 0; }
int MP_RecvHostPacket(u8*, u64*, void*) { return 0; }
u16 MP_RecvReplies(u8*, u64, u16, void*) { return 0; }
int Net_SendPacket(u8*, int, void*) { return 0; }
int Net_RecvPacket(u8*, void*) { return 0; }
void Mic_Start(void*) {} void Mic_Stop(void*) {}
int Mic_ReadInput(s16*, int, void*) { return 0; }
void Camera_Start(int, void*) {} void Camera_Stop(int, void*) {}
void Camera_CaptureFrame(int, u32*, int, int, bool, void*) {}
AACDecoder* AAC_Init() { return nullptr; }
void AAC_DeInit(AACDecoder*) {}
bool AAC_Configure(AACDecoder*, int, int) { return false; }
bool AAC_DecodeFrame(AACDecoder*, const void*, int, void*, int) { return false; }
bool Addon_KeyDown(KeyType, void*) { return false; }
void Addon_RumbleStart(u32, void*) {} void Addon_RumbleStop(void*) {}
float Addon_MotionQuery(MotionQueryType, void*) { return 0; }
DynamicLibrary* DynamicLibrary_Load(const char*) { return nullptr; }
void DynamicLibrary_Unload(DynamicLibrary*) {}
void* DynamicLibrary_LoadFunction(DynamicLibrary*, const char*) { return nullptr; }
}

static std::vector<u8> readfile(const std::string& p) {
    std::ifstream f(p, std::ios::binary); return std::vector<u8>((std::istreambuf_iterator<char>(f)), {});
}

static void shot(NDS* nds, const std::string& path) {
    void *top, *bot;
    if (!nds->GPU.GetFramebuffers(&top, &bot)) { fprintf(stderr,"no fb\n"); return; }
    FILE* f = fopen(path.c_str(), "wb");
    png_structp p = png_create_write_struct(PNG_LIBPNG_VER_STRING, 0,0,0);
    png_infop i = png_create_info_struct(p);
    png_init_io(p, f);
    png_set_IHDR(p, i, 256, 384, 8, PNG_COLOR_TYPE_RGB, 0,0,0);
    png_write_info(p, i);
    u8 row[256*3];
    for (int y = 0; y < 384; y++) {
        u32* src = (u32*)(y < 192 ? top : bot) + (y % 192) * 256;
        for (int x = 0; x < 256; x++) { u32 v = src[x]; row[x*3]=(v>>16)&0xff; row[x*3+1]=(v>>8)&0xff; row[x*3+2]=v&0xff; }
        png_write_row(p, row);
    }
    png_write_end(p, i); png_destroy_write_struct(&p, &i); fclose(f);
}

static u32 rd32(NDS* nds, u32 a) {
    auto& c = nds->ARM9;
    if ((a & c.DTCMMask) == c.DTCMBase) { u32 v; memcpy(&v, &c.DTCM[a & 0x3FFF], 4); return v; }
    if (a < c.ITCMSize) { u32 v; memcpy(&v, &c.ITCM[a & 0x7FFF], 4); return v; }
    return nds->ARM9Read32(a);
}
static void wr32(NDS* nds, u32 a, u32 v) {
    auto& c = nds->ARM9;
    if ((a & c.DTCMMask) == c.DTCMBase) { memcpy(&c.DTCM[a & 0x3FFF], &v, 4); return; }
    nds->ARM9Write32(a, v);
}
static const std::map<std::string,int> KEYS = {{"A",0},{"B",1},{"SELECT",2},{"START",3},{"RIGHT",4},{"LEFT",5},{"UP",6},{"DOWN",7},{"R",8},{"L",9},{"X",10},{"Y",11}};

int main(int argc, char** argv) {
    if (argc < 3) { fprintf(stderr, "usage: headless rom script [loadstate] [savefile]\n"); return 1; }
    std::string rom = argv[1], script = argv[2], state = argc > 3 ? argv[3] : "-";
    if (argc > 4) Platform::savepath = argv[4];
    NDSArgs args; args.JIT = std::nullopt;
    auto nds = std::make_unique<NDS>(std::move(args));
    nds->SetRenderer(std::make_unique<SoftRenderer>(*nds));
    nds->Reset();
    auto data = readfile(rom);
    NDSCart::NDSCartArgs cargs{};
    std::vector<u8> sav;
    if (argc > 4) { sav = readfile(argv[4]); if (!sav.empty()) { cargs.SRAM = std::make_unique<u8[]>(sav.size()); memcpy(cargs.SRAM.get(), sav.data(), sav.size()); cargs.SRAMLength = sav.size(); } }
    auto cart = NDSCart::ParseROM(data.data(), data.size(), nullptr, std::move(cargs));
    if (!cart) { fprintf(stderr, "bad rom\n"); return 1; }
    nds->SetNDSCart(std::move(cart));
    nds->SetupDirectBoot("game.nds");
    nds->Start();
    if (state != "-") {
        auto s = readfile(state);
        Savestate st(s.data(), s.size(), false);
        if (!nds->DoSavestate(&st) || st.Error) { fprintf(stderr, "state load failed\n"); return 1; }
    }
    std::ifstream sf(script); std::string line; u64 frame = 0;
    while (std::getline(sf, line)) {
        std::istringstream ls(line); std::string cmd; ls >> cmd;
        if (cmd.empty() || cmd[0]=='#') continue;
        if (cmd == "run" || cmd == "hold" || cmd == "touch" || cmd == "touchhold") {
            u32 mask = 0xFFF; int n = 1; int tx=-1, ty=-1; std::string keys;
            if (cmd == "run") ls >> n;
            else if (cmd == "hold") { ls >> keys >> n; }
            else if (cmd == "touch") { ls >> tx >> ty >> n; }
            else { ls >> keys >> tx >> ty >> n; }
            std::stringstream ks(keys); std::string k;
            while (std::getline(ks, k, '+')) { auto it = KEYS.find(k); if (it != KEYS.end()) mask &= ~(1u << it->second); else if(!k.empty()) fprintf(stderr,"bad key %s\n",k.c_str()); }
            nds->SetKeyMask(mask);
            if (tx >= 0) nds->TouchScreen(tx, ty); else nds->ReleaseScreen();
            for (int i = 0; i < n; i++) { nds->RunFrame(); frame++; }
            nds->SetKeyMask(0xFFF); nds->ReleaseScreen();
        } else if (cmd == "shot") { std::string p; ls >> p; shot(nds.get(), p); }
        else if (cmd == "savestate") {
            std::string p; ls >> p; Savestate st; nds->DoSavestate(&st); st.Finish();
            FILE* f = fopen(p.c_str(), "wb"); fwrite(st.Buffer(), 1, st.Length(), f); fclose(f);
        } else if (cmd == "peek") {
            std::string a; int n=1; ls >> a >> n; u32 addr = strtoul(a.c_str(), 0, 16);
            printf("%08x:", addr); for (int i=0;i<n;i++) printf(" %08x", rd32(nds.get(), addr+i*4)); printf("\n");
        } else if (cmd == "poke") {
            std::string a, v; ls >> a >> v; wr32(nds.get(), strtoul(a.c_str(),0,16), strtoul(v.c_str(),0,16));
        } else if (cmd == "loadbin") {   // loadbin addr file : write file into RAM, flush icache
            std::string a, p; ls >> a >> p; u32 addr = strtoul(a.c_str(),0,16);
            auto b = readfile(p); for (size_t i=0;i+3<b.size();i+=4) { u32 v; memcpy(&v,&b[i],4); nds->ARM9Write32(addr+i, v); }
            nds->ARM9.ICacheInvalidateAll();
        } else if (cmd == "dump") {
            std::string p; ls >> p; FILE* f=fopen(p.c_str(),"wb"); fwrite(nds->MainRAM,1,0x400000,f); fwrite(nds->ARM9.DTCM,1,0x4000,f); fclose(f);
        } else if (cmd == "wwatch") {
            std::string a; ls >> a; g_wwatchAddr = strtoul(a.c_str(),0,16); g_watchCb = watchcb; g_hits.clear();
        } else if (cmd == "watch") {
            std::string a; ls >> a; g_watchAddr = strtoul(a.c_str(),0,16); g_watchCb = watchcb; g_hits.clear();
        } else if (cmd == "hits") {
            for (auto& h : g_hits) printf("read by pc=%08x lr=%08x\n", h.first-8, h.second); g_hits.clear();
        } else fprintf(stderr, "unknown cmd %s\n", cmd.c_str());
    }
    printf("frames run: %llu\n", (unsigned long long)frame);
    return 0;
}
