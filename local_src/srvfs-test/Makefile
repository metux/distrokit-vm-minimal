
BINARIES=\
	test-localfile

all:	$(BINARIES)

test-localfile:	test-localfile.c common.c
	$(CC) -o $@ $< common.c

clean:
	rm -f $(BINARIES) *.o

install: $(BINARIES)
	mkdir -p $(DESTDIR)/usr/bin
	cp $(BINARIES) $(DESTDIR)/usr/bin
	cp init-srvfs $(DESTDIR)/usr/bin
