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

install:
	 cp string2.a /usr/local/lib/ocaml/
	 cp string2.cma /usr/local/lib/ocaml/
	 cp string2.cmi /usr/local/lib/ocaml/
	 cp string2.cmx /usr/local/lib/ocaml/
	 cp string2.cmxa /usr/local/lib/ocaml/
#	 cp string2.mli /usr/local/lib/ocaml/

clean:
	rm -rf  $(LIB) *.cm* *.o *.a test *~
