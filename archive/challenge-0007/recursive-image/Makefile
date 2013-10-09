all:
	ghc main.hs -odir obj/ -hidir hi/

clean:
	rm -rf hi obj hi-opt obj-opt;

opt:
	ghc -O2 main.hs -odir obj-opt -hidir hi-opt/ 
