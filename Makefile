#
# Mandrake Ada operating system
# Copyright (C) 2026  Winterer, Mathis Aaron
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

ARCH ?= x86
RTS_PATH := $(CURDIR)/build/rts/$(ARCH)
MODE ?= debug

.PHONY: all clean kernel rts

all: rts kernel

rts:
	@mkdir -p build/rts/$(ARCH)/{obj,lib}
	@cd rts && \
	gprbuild -P rts.gpr -v -XMode=$(MODE) -XBoard=$(ARCH)

kernel:
	gprbuild -P ados.gpr -v -XArch=$(ARCH) -XRTS=rts/boards/$(ARCH) -XMode=$(MODE)
	@if [ "$(MODE)" = "release" ]; then\
		@strip -g -S -d build/$(ARCH)/bin/ados.out;\
	fi

x86:
	$(MAKE) ARCH=x86

riscv64:
	$(MAKE) ARCH=riscv64

clean:
	rm -rf build/

