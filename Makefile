GCC_FLAGS=-Wall -Wextra -Wpedantic -ansi -O2 -Ilib/c
GHC_FLAGS=-Wall -O2 -ilib/hs --make

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
	bin/problem-40 \
	bin/problem-41 \
	bin/problem-43 \
	bin/problem-44 \
	bin/problem-45 \
	bin/problem-46 \
	bin/problem-47 \
	bin/problem-48 \
	bin/problem-49 \
	bin/problem-50 \
	bin/problem-51 \
	bin/problem-52 \
	bin/problem-54 \
	bin/problem-55 \
	bin/problem-56 \
	bin/problem-57 \
	bin/problem-58 \
	bin/problem-60 \
	bin/problem-61 \
	bin/problem-62 \
	bin/problem-63 \
	bin/problem-64 \
	bin/problem-65 \
	bin/problem-66 \
	bin/problem-76 \
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

bin/problem-32: problem-32.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ problem-32.o lib/c/digits.o

bin/problem-36: problem-36.o
	gcc -o $@ $<

bin/problem-37: problem-37.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-38: problem-38.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-40: problem-40.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-41: problem-41.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ problem-41.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-43: problem-43.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-44: problem-44.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-45: problem-45.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-46: problem-46.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ problem-46.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-47: problem-47.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-48: problem-48.o
	gcc -o $@ $<

bin/problem-49: problem-49.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ problem-49.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-50: problem-50.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ problem-50.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-51: problem-51.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-52: problem-52.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ problem-52.o lib/c/digits.o

bin/problem-54: problem-54.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-55: problem-55.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-56: problem-56.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-57: problem-57.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-58: problem-58.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ problem-58.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-60: problem-60.ml
	ocamlopt -o $@ $<

bin/problem-61: problem-61.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-62: problem-62.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-63: problem-63.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-64: problem-64.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-65: problem-65.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-66: problem-66.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-76: problem-76.ml
	ocamlopt -o $@ $<

bin/problem-81: problem-81.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ problem-81.o lib/c/matrix.o

bin/problem-82: problem-82.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ problem-82.o lib/c/matrix.o

bin/problem-83: problem-83.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ problem-83.o lib/c/matrix.o

%.o: %.c
	gcc ${GCC_FLAGS} -c -o $@ $<

clean:
	rm -f *.o
	rm -f *.hi
	rm -rf bin

bin:
	mkdir bin
