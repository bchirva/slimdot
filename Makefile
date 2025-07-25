SCRIPT = slimdot

PREFIX = /usr/bin

install:
	cp $(SCRIPT) $(PREFIX)/$(SCRIPT)
	chmod +x $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) installed to $(PREFIX)"
	cp docs/slimdot.1.gz /usr/share/man/man1/
	mandb
	

uninstall:
	rm -f $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) removed from $(PREFIX)"
	rm /usr/share/man/man1/slimdot.1.gz
	mandb
