/*
Copyright 2012,2013 Jun Wako <wakojun@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#include QMK_KEYBOARD_H


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
#define _DVORAK 0
#define _QWERTY 1
#define _FN1 2
#define _FN2 3

enum custom_keycodes {
  DVORAK = SAFE_RANGE,
};
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_DVORAK] = LAYOUT_60_ansi(
    KC_GRV,           KC_1,     KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,        KC_8,    KC_9,        KC_0,    KC_LBRC, KC_RBRC, KC_BSPC, \
    KC_TAB,           KC_QUOT,  KC_COMM, KC_DOT,  KC_P,    KC_Y,    KC_F,    KC_G,        KC_C,    KC_R,        KC_L,    KC_SLSH, KC_EQL,  KC_BSLS, \
    KC_RCTL,          KC_A,     KC_O,    KC_E,    KC_U,    KC_I,    KC_D,    KC_H,        KC_T,    KC_N,        KC_S,    KC_MINS,      KC_ENT,      \
             KC_LSFT,           KC_SCLN, KC_Q,    KC_J,    KC_K,    KC_X,    KC_B,        KC_M,    KC_W,        KC_V,    KC_Z,         KC_RSFT,     \
    LT(_FN1, KC_ESC), KC_LGUI,  KC_LALT,                            KC_SPC,                                     KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
  ),
  [_QWERTY] = LAYOUT_60_ansi(
    KC_GRV,           KC_1,     KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,        KC_8,    KC_9,        KC_0,    KC_MINS, KC_EQL,  KC_BSPC, \
    KC_TAB,           KC_Q,     KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,        KC_I,    KC_O,        KC_P,    KC_LBRC, KC_RBRC, KC_BSLS, \
    KC_RCTL,          KC_A,     KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,        KC_K,    KC_L,        KC_SCLN, KC_QUOT,      KC_ENT,      \
             KC_LSFT,           KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,        KC_M,    KC_COMM,     KC_DOT,  KC_SLSH,      KC_RSFT,     \
    LT(_FN1, KC_ESC), KC_LGUI,  KC_LALT,                            KC_SPC,                                     KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
  ),
  [_FN1] = LAYOUT_60_ansi(
    KC_ESC,           KC_F1,    KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,       KC_F8,   KC_F9,       KC_F10,  KC_F11,  KC_F12,  KC_DEL,  \
    KC_NO,            KC_MUTE,  KC_VOLD, KC_VOLU, KC_NO,   KC_NO,   KC_NO,   KC_HOME,     KC_PGUP, KC_NO,       KC_NO,   BL_DEC,  BL_INC,  KC_PSCR, \
    KC_LCTL,          KC_MPRV,  KC_MPLY, KC_MNXT, KC_NO,   KC_NO,   KC_NO,   KC_LEFT,     KC_DOWN, KC_UP,       KC_RGHT, KC_NO,        KC_NO,       \
             KC_LSFT,           KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_N,        KC_END,  KC_PGDN,     KC_NO,   BL_TOGG,      KC_NO,       \
    KC_TRNS,          MO(_FN2), KC_RALT,                            KC_NO,                                      KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
  ),
  [_FN2] = LAYOUT_60_ansi(
    KC_NO,            KC_NO,    KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,       KC_NO,   KC_NO,       KC_NO,   KC_NO,   KC_NO,   KC_NO,   \
    KC_NO,            KC_NO,    KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,       KC_NO,   KC_NO,       KC_NO,   KC_NO,   KC_NO,   RESET,   \
    KC_NO,            KC_NO,    KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   DF(_QWERTY), KC_NO,   DF(_DVORAK), KC_NO,   KC_NO,        KC_NO,       \
             KC_NO,             KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,       KC_NO,   KC_NO,       KC_NO,   KC_NO,        KC_NO,       \
    KC_NO,            KC_TRNS,  KC_NO,                              KC_NO,                                      KC_NO,   KC_NO,   KC_NO,   KC_NO)
};
