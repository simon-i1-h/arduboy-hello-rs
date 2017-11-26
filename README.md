# arduboy-hello-rs
![hello, arduboy and rust](demo.gif)
## Install
### Install Rust with rustup
<https://www.rust-lang.org/en-US/install.html>
### Install Arduino IDE
<https://www.arduino.cc/en/Main/Software>
### Setup Arduboy
<https://community.arduboy.com/t/quick-start-guide>
Requirement: 「Arduboy」library
### Setup AVR-Rust
~~~~~~~~~~~~~~~~~~~~
mkdir -p ~/ws/avr-rust-build/build/
cd ~/ws/avr-rust-build/
git clone https://github.com/avr-rust/rust.git
(cd rust && git checkout b5a0d3b7b87eafed7499d69bd543648cfb139b0c)
cd build
../rust/configure \
  --enable-debug \
  --disable-docs \
  --enable-llvm-assertions \
  --enable-debug-assertions \
  --enable-optimize
make # Wait for about an hour
rustup toolchain link avr-toolchain "$(realpath "$(find . -name stage2)")"
# ↓for xargo
RUST_SRC="$(rustc +avr-toolchain --print sysroot)/lib/rustlib/src/"
mkdir -p "${RUST_SRC}"
ln -s "$(realpath ../rust/)" "${RUST_SRC}"
~~~~~~~~~~~~~~~~~~~~
### Setup Xargo
~~~~~~~~~~~~~~~~~~~~
cargo install xargo
~~~~~~~~~~~~~~~~~~~~
### Build
~~~~~~~~~~~~~~~~~~~~
cd ~/ws
git clone https://github.com/simon-i1-h/arduboy-hello-rs.git
cd ~/ws/arduboy-hello-rs
rustup override set avr-toolchain
editor Makefile # edit `IDE_PATH' and `PORT'
make verify # check
make upload
~~~~~~~~~~~~~~~~~~~~
## Tips
<https://help.ubuntu.com/community/SerialConsoleHowto>
## License
MIT License
