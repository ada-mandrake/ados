ARCH ?= x86
RTS_PATH := $(CURDIR)/build/rts/$(ARCH)
MODE ?= debug

.PHONY: all clean kernel rts

all: rts kernel

rts:
	mkdir -p build/rts/$(ARCH)/{obj,lib}
	cd rts && \
	gprbuild -P rts.gpr -v -XMode=$(MODE) -XBoard=$(ARCH)

kernel:
	gprbuild -P ados.gpr -v -XArch=$(ARCH) -XRTS=rts/boards/$(ARCH) -XMode=$(MODE)
	if [ "$(MODE)" = "release" ]; then\
		strip -g -S -d build/$(ARCH)/bin/ados.out;\
	fi

x86:
	$(MAKE) ARCH=x86

x86_64:
	$(MAKE) ARCH=x86_64

riscv32:
	@printf "This target is broken\n"

riscv64:
	$(MAKE) ARCH=riscv64

clean:
	rm -rf build/

