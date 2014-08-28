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
	bin/problem-36 \
	bin/problem-37 \
	bin/problem-47 \
	bin/problem-81

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

bin/problem-36: problem-36.o
	gcc -o $@ $<

bin/problem-37: problem-37.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-47: problem-47.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-81: problem-81.o lib/matrix.o lib/matrix.h
	gcc -o $@ problem-81.o lib/matrix.o

%.o: %.c
	gcc ${GCC_FLAGS} -c -o $@ $<

clean:
	rm -f *.o
	rm -f *.hi
	rm -rf

bin:
	mkdir bin
