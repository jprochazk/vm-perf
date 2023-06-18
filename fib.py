def fib(n):
    a = 0.0
    b = 1.0
    i = 0
    while i < n:
        tmp = a + b
        a = b
        b = tmp
    return a


from dis import dis

dis(fib)
