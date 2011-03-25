# svkbd - simple virtual keyboard
# See LICENSE file for copyright and license details.

include config.mk

SRC = svkbd.c
LAYOUTS = en de arrows

all: options svkbd

options:
	@echo svkbd build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LAYOUT   = ${LAYOUT}"

config.h: config.mk
	@echo creating $@ from config.def.h
	@cp config.def.h $@


svkbd: svkbd.en
	@echo CP $@
	@cp $< $@

svkbd.%: layout.%.h config.h ${SRC}
	@echo creating layout.h from $<
	@cp $< layout.h
	@echo CC -o $@
	@${CC} -o $@ ${SRC} ${LDFLAGS} ${CFLAGS}

clean:
	@echo cleaning
	@for i in ${LAYOUTS}; do rm svkbd.$$i 2> /dev/null; done; true
	@rm -f svkbd ${OBJ} svkbd-${VERSION}.tar.gz 2> /dev/null; true

dist: clean
	@echo creating dist tarball
	@mkdir -p svkbd-${VERSION}
	@cp LICENSE Makefile README config.def.h config.mk \
		${SRC} svkbd-${VERSION}
	@for i in ${LAYOUTS}; do cp layout.$$i.h svkbd.${VERSION} || exit 1; done
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
