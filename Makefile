LIB = string2.cma string2.cmxa

all: $(LIB)

%.cmo: %.ml
	ocamlc -c $^ -o $@

%.cma : %.ml
	ocamlc -a $^ -o $@

%.o: %.ml
	ocamlopt -c $^ -o $@

%.cmxa : %.ml
	ocamlopt -a $^ -o $@

test: string2.cma test.cmo
	ocamlc $^ -o $@
	./$@ azertyuiop

testopt: string2.cmxa test.o
	ocamlopt $^ -o $@
	./$@ azertyuiop

clean:
	rm -rf  $(LIB) *.cm* *.o *.a test *~
