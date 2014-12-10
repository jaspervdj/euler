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
	bin/problem-68 \
	bin/problem-76 \
	bin/problem-81 \
	bin/problem-82 \
	bin/problem-83

bin/problem-19: src/problem-19.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-23: src/problem-23.o
	gcc -o $@ $<

bin/problem-24: src/problem-24.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-25: src/problem-25.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-26: src/problem-26.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-27: src/problem-27.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-31: src/problem-31.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-32: src/problem-32.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-32.o lib/c/digits.o

bin/problem-36: src/problem-36.o
	gcc -o $@ $<

bin/problem-37: src/problem-37.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-38: src/problem-38.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-40: src/problem-40.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-41: src/problem-41.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-41.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-43: src/problem-43.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-44: src/problem-44.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-45: src/problem-45.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-46: src/problem-46.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-46.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-47: src/problem-47.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-48: src/problem-48.o
	gcc -o $@ $<

bin/problem-49: src/problem-49.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-49.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-50: src/problem-50.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-50.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-51: src/problem-51.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-52: src/problem-52.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-52.o lib/c/digits.o

bin/problem-54: src/problem-54.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-55: src/problem-55.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-56: src/problem-56.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-57: src/problem-57.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-58: src/problem-58.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-58.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-60: src/problem-60.ml
	ocamlopt -o $@ $<

bin/problem-61: src/problem-61.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-62: src/problem-62.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-63: src/problem-63.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-64: src/problem-64.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-65: src/problem-65.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-66: src/problem-66.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-68: src/problem-68.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-76: src/problem-76.ml
	ocamlopt -o $@ $<

bin/problem-81: src/problem-81.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-81.o lib/c/matrix.o

bin/problem-82: src/problem-82.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-82.o lib/c/matrix.o

bin/problem-83: src/problem-83.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-83.o lib/c/matrix.o

%.o: %.c
	gcc ${GCC_FLAGS} -c -o $@ $<

clean:
	rm -f src/*.o
	rm -f src/*.hi
	rm -f src/*.cmi
	rm -f src/*.cmo
	rm -f src/*.cmx
	rm -rf bin

bin:
	mkdir bin
