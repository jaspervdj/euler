def factors(n):
    i = 2
    while i <= n:
        if n % i == 0:
            yield i
            n = n / i
        else:
            i = i + 1

def is_divisable_by_any(n, divisors):
    for d in divisors:
        if n % d == 0:
            return True
    return False

def proper_divisors(n):
    yield 1
    d = 2
    while d * d <= n:
        if n % d == 0:
            yield d
            if d * d != n:
                yield n // d
        d += 1

def divisors(n):
    if n == 1:
        yield 1
    else:
        for d in proper_divisors(n): yield d
        yield n

def primes():
    yield 2
    discovered = [2]
    n = 3
    while True:
        if not is_divisable_by_any(n, discovered):
            yield n
            discovered.append(n)

        n += 2

def sieve(n):
    s = [True] * (n + 1)
    s[0] = False
    s[1] = False

    prime = 2
    while prime <= n:
        for not_prime in range(prime + prime, n + 1, prime):
            s[not_prime] = False

        prime += 1
        while prime <= n and not s[prime]: prime += 1

    return s
