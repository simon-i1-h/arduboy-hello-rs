#IDE_PATH := ${HOME}/opt/arduino-1.8.5
#PORT := /dev/ttyACM0

ifndef IDE_PATH
$(error IDE_PATH is not defined)
endif

ifndef PORT
$(error PORT is not defined)
endif

SYSROOT := $(shell rustc +avr-toolchain --print sysroot)

# TODO Better implementation
# see https://github.com/arduino/Arduino/pull/5338
IDE_PREF := $(shell grep -E '^recipe\.c\.combine\.pattern=.*$$' \
			'$(IDE_PATH)/hardware/arduino/avr/platform.txt' \
		| sed -r 's@(.*)@\1 target/arduboy/release/libhello.a@')

verify:
	$(call do_build,--verify)
upload:
	$(call do_build,--upload)

define do_build
	: IDE_PATH := $(IDE_PATH)
	: PORT := $(PORT)
	: SYSROOT := $(SYSROOT)
	: IDE_PREF := $(IDE_PREF)
	: ----------build-rust-program----------
	RUST_BACKTRACE=1 \
	XARGO_RUST_SRC='$(SYSROOT)/lib/rustlib/src/' \
	RUSTC='$(SYSROOT)/bin/rustc' \
	RUSTDOC='$(SYSROOT)/bin/rustdoc' \
	xargo build -vvv --release --target=arduboy
	: ----------build-arduboy-game----------
	'$(IDE_PATH)/arduino' $1 -v --board arduboy:avr:arduboy \
		--port '$(PORT)' --pref '$(IDE_PREF)' ffi.ino
endef

.PHONY: verify upload
