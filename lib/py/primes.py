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
