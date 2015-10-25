#!/usr/bin/python3
import primes

# Compute the factors as a dict.
def factor_dict(number):
    d = dict()
    for f in primes.factors(number):
        if f in d:
            d[f] += 1
        else:
            d[f] = 1
    return d

# Join all these dictionaries.
lcm_factors = dict()
for number in range(1, 21):
    factors = factor_dict(number)
    for k in factors:
        if k in lcm_factors:
            lcm_factors[k] = max(lcm_factors[k], factors[k])
        else:
            lcm_factors[k] = factors[k]

# Now we have the factors of the lcm. Multiply them all.
lcm = 1
for k in lcm_factors:
    lcm = lcm * (k ** lcm_factors[k])

print(lcm)
