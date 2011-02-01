# svkbd - simple virtual keyboard
# See LICENSE file for copyright and license details.

include config.mk

SRC = svkbd.c
OBJ = ${SRC:.c=.o}

all: options svkbd

options:
	@echo svkbd build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

svkbd: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f svkbd ${OBJ} svkbd-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p svkbd-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk \
		${SRC} svkbd-${VERSION}
	@tar -cf svkbd-${VERSION}.tar svkbd-${VERSION}
	@gzip svkbd-${VERSION}.tar
	@rm -rf svkbd-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f svkbd ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/svkbd
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
#	@sed "s/VERSION/${VERSION}/g" < svkbd.1 > ${DESTDIR}${MANPREFIX}/man1/svkbd.1
#	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/svkbd.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/svkbd
#	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
#	@rm -f ${DESTDIR}${MANPREFIX}/man1/svkbd.1

.PHONY: all options clean dist install uninstall
