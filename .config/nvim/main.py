def prime(number: int):
    sieve = [True] * number

    res = []

    for i in range(2, number):
        if sieve[i]:
            res.append(i)
            for j in range(i * i, number, i):
                sieve[j] = False 
    return res

xs = prime(100)

print(xs)
