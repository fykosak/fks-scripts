DESTDIR=
DST_bin=$(DESTDIR)/usr/bin
DST_share=$(DESTDIR)/usr/share/fks
DST_conf=$(DESTDIR)/etc

build:
	true

clean:
	true

install:
	mkdir -p $(DST_bin)
	mkdir -p $(DST_share)
	mkdir -p $(DST_conf)
	cp -r scripts/bin/* -t $(DST_bin)/
	cp -r scripts/share/* -t $(DST_share)/
	cp -r scripts/conf/* -t $(DST_conf)/
