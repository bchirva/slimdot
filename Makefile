SCRIPT = slimdot

PREFIX = /usr/bin

install:
	@cp $(SCRIPT) $(PREFIX)/$(SCRIPT)
	@chmod +x $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) installed to $(PREFIX)"
	@gzip -c docs/slimdot.1 > /usr/share/man/man1/slimdot.1.gz
	@mandb > /dev/null 
	

uninstall:
	@rm -f $(PREFIX)/$(SCRIPT)
	@echo "$(SCRIPT) removed from $(PREFIX)"
	@rm /usr/share/man/man1/slimdot.1.gz
	@mandb > /dev/null
