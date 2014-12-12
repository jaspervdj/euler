GCC_FLAGS=-Wall -Wextra -Wpedantic -ansi -O2 -Ilib/c
GHC_FLAGS=-Wall -O2 -ilib/hs --make
OCAMLC_FLAGS=-I lib/ml

default: \
	bin \
	bin/problem-019 \
	bin/problem-023 \
	bin/problem-024 \
	bin/problem-025 \
	bin/problem-026 \
	bin/problem-027 \
	bin/problem-031 \
	bin/problem-032 \
	bin/problem-036 \
	bin/problem-037 \
	bin/problem-038 \
	bin/problem-040 \
	bin/problem-041 \
	bin/problem-043 \
	bin/problem-044 \
	bin/problem-045 \
	bin/problem-046 \
	bin/problem-047 \
	bin/problem-048 \
	bin/problem-049 \
	bin/problem-050 \
	bin/problem-051 \
	bin/problem-052 \
	bin/problem-054 \
	bin/problem-055 \
	bin/problem-056 \
	bin/problem-057 \
	bin/problem-058 \
	bin/problem-060 \
	bin/problem-061 \
	bin/problem-062 \
	bin/problem-063 \
	bin/problem-064 \
	bin/problem-065 \
	bin/problem-066 \
	bin/problem-068 \
	bin/problem-069 \
	bin/problem-070 \
	bin/problem-071 \
	bin/problem-072 \
	bin/problem-076 \
	bin/problem-081 \
	bin/problem-082 \
	bin/problem-083

bin/problem-019: src/problem-019.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-023: src/problem-023.o
	gcc -o $@ $<

bin/problem-024: src/problem-024.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-025: src/problem-025.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-026: src/problem-026.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-027: src/problem-027.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-031: src/problem-031.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-032: src/problem-032.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-032.o lib/c/digits.o

bin/problem-036: src/problem-036.o
	gcc -o $@ $<

bin/problem-037: src/problem-037.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-038: src/problem-038.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-040: src/problem-040.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-041: src/problem-041.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-041.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-043: src/problem-043.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-044: src/problem-044.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-045: src/problem-045.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-046: src/problem-046.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-046.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-047: src/problem-047.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-048: src/problem-048.o
	gcc -o $@ $<

bin/problem-049: src/problem-049.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-049.o lib/c/bit-vector.o lib/c/sieve.o lib/c/digits.o

bin/problem-050: src/problem-050.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-050.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-051: src/problem-051.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-052: src/problem-052.o \
		lib/c/digits.o lib/c/digits.h
	gcc -o $@ src/problem-052.o lib/c/digits.o

bin/problem-054: src/problem-054.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-055: src/problem-055.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-056: src/problem-056.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-057: src/problem-057.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-058: src/problem-058.o \
		lib/c/bit-vector.o lib/c/bit-vector.h \
		lib/c/sieve.o lib/c/sieve.h
	gcc -o $@ src/problem-058.o lib/c/bit-vector.o lib/c/sieve.o

bin/problem-060: src/problem-060.ml
	ocamlopt -o $@ $<

bin/problem-061: src/problem-061.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-062: src/problem-062.ml lib/ml/utils.cmx
	ocamlopt -o $@ ${OCAMLC_FLAGS} nums.cmxa utils.cmx $<

bin/problem-063: src/problem-063.ml lib/ml/utils.cmx
	ocamlopt -o $@ ${OCAMLC_FLAGS} nums.cmxa utils.cmx $<

bin/problem-064: src/problem-064.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-065: src/problem-065.ml
	ocamlopt -o $@ nums.cmxa $<

bin/problem-066: src/problem-066.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-068: src/problem-068.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-069: src/problem-069.ml lib/ml/utils.cmx
	ocamlopt -o $@ ${OCAMLC_FLAGS} nums.cmxa utils.cmx $<

bin/problem-070: src/problem-070.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-071: src/problem-071.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-072: src/problem-072.hs
	ghc -o $@ ${GHC_FLAGS} $<

bin/problem-076: src/problem-076.ml
	ocamlopt -o $@ $<

bin/problem-081: src/problem-081.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-081.o lib/c/matrix.o

bin/problem-082: src/problem-082.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-082.o lib/c/matrix.o

bin/problem-083: src/problem-083.o lib/c/matrix.o lib/c/matrix.h
	gcc -o $@ src/problem-083.o lib/c/matrix.o

%.o: %.c
	gcc ${GCC_FLAGS} -c -o $@ $<

lib/ml/utils.cmx: lib/ml/utils.ml
	ocamlopt -c ${OCAMLC_FLAGS} $<

lib/ml/sieve.cmx: lib/ml/sieve.ml lib/ml/utils.cmx
	ocamlopt -c ${OCAMLC_FLAGS} utils.cmx $<

clean:
	rm -f src/*.o
	rm -f src/*.hi
	rm -f src/*.cmi
	rm -f src/*.cmo
	rm -f src/*.cmx
	rm -rf bin

bin:
	mkdir bin
