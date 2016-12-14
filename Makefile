OUTDIR=bin/

compile:
	mkdir -p $(OUTDIR)
	erlc -o $(OUTDIR) src/*.erl 

test:
	$(MAKE) compile
	erl -noshell -pa $(OUTDIR) -eval "eunit:test(interval_merging, [verbose])" -s init stop


tests:
	$(MAKE) test