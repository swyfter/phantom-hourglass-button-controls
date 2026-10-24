def build():
    T=[]
    T.append(((3,0,0),(0,0,0)))  # RUN size0
    for s in range(0,18): T.append(((1,s,0),(0,0,0)))
    for m in range(9):
        T.append(((2,0,m),(0,0,0)))
        for s in range(4,19): T.append(((2,s,m),(0,0,0)))
    for m in range(6):
        for a in range(1,5):
            for c in range(4,7): T.append(((1,a,0),(2,c,m)))
    for m in range(6,9):
        for a in range(1,5): T.append(((1,a,0),(2,4,m)))
    for m in range(9): T.append(((2,4,m),(1,1,0)))
    return T
T=build()
