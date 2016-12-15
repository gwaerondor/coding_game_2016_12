OUTDIR=bin/

compile:
	mkdir -p $(OUTDIR)
	erlc -o $(OUTDIR) src/erolars*.erl 

test:
	$(MAKE) compile
	erl -noshell -pa $(OUTDIR) -eval "eunit:test(erolars, [verbose])" -s init stop
