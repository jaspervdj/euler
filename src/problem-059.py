#!/usr/bin/env python3

english_character_distribution = {
    'a': 8.167,
    'b': 1.492,
    'c': 2.782,
    'd': 4.253,
    'e': 12.702,
    'f': 2.228,
    'g': 2.015,
    'h': 6.094,
    'i': 6.966,
    'j': 0.153,
    'k': 0.772,
    'l': 4.025,
    'm': 2.406,
    'n': 6.749,
    'o': 7.507,
    'p': 1.929,
    'q': 0.095,
    'r': 5.987,
    's': 6.327,
    't': 9.056,
    'u': 2.758,
    'v': 0.978,
    'w': 2.361,
    'x': 0.150,
    'y': 1.974,
    'z': 0.074
}

# Convert from percentages
for c in english_character_distribution:
    english_character_distribution[c] = english_character_distribution[c] / 100

def score(distribution):
    s = 0
    for c in english_character_distribution:
        english = english_character_distribution[c]
        if c in distribution: dist = distribution[c]
        else: dist = 0
        s += (english - dist) * (english - dist)
    return s

def character_distribution(string):
    dist = dict()
    total = 0
    for c in string:
        c = c.lower()
        if c in dist: dist[c] += 1
        else: dist[c] = 1
        total += 1
    for c in dist:
        dist[c] = float(dist[c]) / float(total)
    return dist

def alpha_character_distribution(string):
    return character_distribution(chr(c) for c in string if chr(c).isalpha())

def decrypt(cipher, password):
    decrypted = []
    password_idx = 0
    for c in cipher:
        decrypted.append(c ^ password[password_idx])
        password_idx += 1
        if password_idx >= len(password): password_idx = 0
    return decrypted

def read_cipher():
    with open("in/p059_cipher.txt") as f:
        return list(map(int, f.read().split(',')))

def passwords():
    a = ord('a')
    z = ord('z')
    for c1 in range(a, z):
        for c2 in range(a, z):
            for c3 in range(a, z):
                yield [c1, c2, c3]

best_score = None
best_plain = None

cipher = read_cipher()
for password in passwords():
    plain = decrypt(cipher, password)
    s = score(alpha_character_distribution(plain))

    if not best_score or s < best_score:
        best_score = s
        best_plain = plain

plain_string = ''.join(chr(c) for c in best_plain)
result = sum(best_plain)
print(result)
