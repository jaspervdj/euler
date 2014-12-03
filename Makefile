GCC_FLAGS=-Wall -Wextra -Wpedantic -ansi -O2 -Ilib
GHC_FLAGS=-Wall -ilib --make

default: \
	bin \
	bin/problem-19 \
	bin/problem-23 \
	bin/problem-24 \
	bin/problem-25 \
	bin/problem-26 \
	bin/problem-27 \
	bin/problem-31 \
	bin/problem-32 \
	bin/problem-36 \
	bin/problem-37 \
	bin/problem-38 \
	bin/problem-44 \
	bin/problem-45 \
	bin/problem-46 \
	bin/problem-47 \
	bin/problem-48 \
	bin/problem-49 \
	bin/problem-50 \
	bin/problem-81 \
	bin/problem-82 \
	bin/problem-83

bin/problem-19: problem-19.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-23: problem-23.o
	gcc -o $@ $<

bin/problem-24: problem-24.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-25: problem-25.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-26: problem-26.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-27: problem-27.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-31: problem-31.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-32: problem-32.o
	gcc -o $@ $<

bin/problem-36: problem-36.o
	gcc -o $@ $<

bin/problem-37: problem-37.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-38: problem-38.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-44: problem-44.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-45: problem-45.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-46: problem-46.o \
		lib/bit-vector.o lib/bit-vector.h \
		lib/sieve.o lib/sieve.h
	gcc -o $@ problem-46.o lib/bit-vector.o lib/sieve.o

bin/problem-47: problem-47.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-48: problem-48.o
	gcc -o $@ $<

bin/problem-49: problem-49.o \
		lib/bit-vector.o lib/bit-vector.h \
		lib/sieve.o lib/sieve.h
	gcc -o $@ problem-49.o lib/bit-vector.o lib/sieve.o

bin/problem-50: problem-50.o \
		lib/bit-vector.o lib/bit-vector.h \
		lib/sieve.o lib/sieve.h
	gcc -o $@ problem-50.o lib/bit-vector.o lib/sieve.o

bin/problem-81: problem-81.o lib/matrix.o lib/matrix.h
	gcc -o $@ problem-81.o lib/matrix.o

bin/problem-82: problem-82.o lib/matrix.o lib/matrix.h
	gcc -o $@ problem-82.o lib/matrix.o

bin/problem-83: problem-83.o lib/matrix.o lib/matrix.h
	gcc -o $@ problem-83.o lib/matrix.o

%.o: %.c
	gcc ${GCC_FLAGS} -c -o $@ $<

clean:
	rm -f *.o
	rm -f *.hi
	rm -rf bin

bin:
	mkdir bin
