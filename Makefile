# dusk - a dwm fork
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dusk.c util.c
OBJ = ${SRC:.c=.o}

all: dusk duskc

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dusk: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

duskc:
	${CC} -o $@ lib/ipc/duskc.c ${LDFLAGS}

clean:
	rm -f dusk ${OBJ}
	rm -f duskc

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -Dm755 dusk ${DESTDIR}${PREFIX}/bin
	install -Dm755 duskc ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dusk.1 > ${DESTDIR}${MANPREFIX}/man1/dusk.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dusk.1
	mkdir -p /usr/share/xsessions
	test -f /usr/share/xsessions/dusk.desktop || install -Dm644 dusk.desktop /usr/share/xsessions/

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dusk\
		${DESTDIR}${MANPREFIX}/man1/dusk.1\
		/usr/share/xsessions/dusk.desktop

.PHONY: all clean install uninstall
