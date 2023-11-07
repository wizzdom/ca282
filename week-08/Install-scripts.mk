dest = $(HOME)/local/bin
source = $(wildcard [a-z]*)

install: $(dest) $(addprefix $(dest)/, $(source))
	@true

$(dest)/%: %
	@install -v -m 0555 $< $@

$(dest):
	mkdir -vp $@

.PHONY: install
