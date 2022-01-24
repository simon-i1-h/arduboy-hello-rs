# arduboy-hello-rs

![hello, arduboy and rust](demo.gif)

## Build

Main requirements:

- `rustup`
- `arduino-cli`

See also `Dockerfile` for details.

```
PORT=/dev/ttyACM0 # e.g.
make PORT=$PORT setup && make && make upload
```
