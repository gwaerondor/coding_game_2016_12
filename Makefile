OUTDIR=bin/

compile:
	mkdir -p $(OUTDIR)
	erlc -o $(OUTDIR) src/*.erl 

test_interval:
	$(MAKE) compile
	erl -noshell -pa $(OUTDIR) -eval "eunit:test(interval_merging, [verbose])" -s init stop

test_tree:
	$(MAKE) compile
	erl -noshell -pa $(OUTDIR) -eval "eunit:test(tree_construction, [verbose])" -s init stop

test:
	$(MAKE) test_interval
	$(MAKE) test_tree