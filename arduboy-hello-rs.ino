#include "Arduboy.h"

Arduboy arduboy;

extern "C" {
    void arduboy_begin_no_logo(void) {
        arduboy.beginNoLogo();
    }

    void arduboy_set_frame_rate(uint8_t rate) {
        arduboy.setFrameRate(rate);
    }

    int arduboy_next_frame(void) {
        return arduboy.nextFrame();
    }

    void arduboy_clear(void) {
        arduboy.clear();
    }

    void arduboy_set_cursor(int16_t x, int16_t y) {
        arduboy.setCursor(x, y);
    }

    void arduboy_print(const char *cstr) {
        arduboy.print(cstr);
    }

    void arduboy_display(void) {
        arduboy.display();
    }

    int arduboy_pressed(uint8_t buttons) {
        return arduboy.pressed(buttons);
    }

    void tunes_tone(unsigned int frequency, unsigned long duration) {
        arduboy.tunes.tone(frequency, duration);
    }
}
