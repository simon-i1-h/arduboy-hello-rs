.PHONY: all setup cargo build upload

-include options.mk

ifndef PORT
  $(error PORT is not defined)
else
  $(shell printf 'PORT = %s\n' $(PORT) > options.mk)
endif

BOARD = arduino:avr:leonardo
TARGET = avr-unknown-gnu-atmega32u4
RECIPE = "$$(arduino-cli compile -b $(BOARD) --show-properties \
		| grep -E '^recipe\.c\.combine\.pattern=.*$$' \
		| sed -r 's@(.*)@\1 target/$(TARGET)/release/libhello.a@')"

all: build

setup:
	# workaround https://github.com/rust-lang/compiler-builtins/issues/400
	rustup toolchain install nightly-2021-01-07
	rustup override set nightly-2021-01-07
	rustup component add rust-src --toolchain nightly-2021-01-07
	rustc --print target-spec-json -Z unstable-options \
		--target avr-unknown-gnu-atmega328 \
		| sed 's/atmega328/atmega32u4/g' \
		| jq '."is-builtin" = false' \
		> $(TARGET).json
	arduino-cli core install arduino:avr
	arduino-cli lib install Arduboy

cargo:
	cargo build -Z build-std=core --target $(TARGET).json --release

build: cargo
	arduino-cli compile --fqbn $(BOARD) --build-property $(RECIPE)

upload:
	arduino-cli upload --verify --fqbn $(BOARD) --port $(PORT)
