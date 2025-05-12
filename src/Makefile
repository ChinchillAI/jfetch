jarch:
	gcc -o jfetch -Wall -Wextra -Wno-error=format-security jfetch.c

install: jarch
	mkdir -p $(out)/bin
	cp jfetch $(out)/bin/jfetch
