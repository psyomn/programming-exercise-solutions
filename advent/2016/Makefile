all: native byte

native:
	ocamlbuild -use-ocamlfind -tag bin_annot main.native -lib str

byte:
	ocamlbuild -use-ocamlfind -tag bin_annot main.byte -lib str

clean:
	ocamlbuild -clean
