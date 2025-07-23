SCRIPT = slimdot

PREFIX = /usr/bin

install:
	cp $(SCRIPT) $(PREFIX)/$(SCRIPT)
	chmod +x $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) installed to $(PREFIX)"

uninstall:
	rm -f $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) removed from $(PREFIX)"
