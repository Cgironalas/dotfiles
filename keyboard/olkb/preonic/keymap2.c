/* Copyright 2015-2017 Jack Humbert
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "muse.h"

enum preonic_layers {
  _DVORAK,
  _QWERTY,
  _LOWER,
  _RAISE,
  _ADJUST
};

enum preonic_keycodes {
  DVORAK = SAFE_RANGE,
  QWERTY,
  LOWER,
  RAISE,
  BACKLIT
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Dvorak
 * ,--------------------------------------------------------------------------------------------.
 * |   `    |   1   |   2   |   3   |   4   |  5  |  6  |   7   |   8   |   9   |   0   | Bksp  |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Tab    |   "   |   ,   |   .   |   P   |  Y  |  F  |   G   |   C   |   R   |   L   | Del   |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | R_Ctrl |   A   |   O   |   E   |   U   |  I  |  D  |   H   |   T   |   N   |   S   |   /   |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Shift  |   ;   |   Q   |   J   |   K   |  X  |  B  |   M   |   W   |   V   |   Z   | Enter |
 * |--------+-------+-------+-------+-------+-----+-----+-------+-------+-------+-------+-------|
 * | ESC    | R_Alt |  GUI  |  Alt  | Lower |   Space   | Raise | Left  | Down  |  Up   | Right |
 * `--------------------------------------------------------------------------------------------'
 */
[_DVORAK] = LAYOUT_preonic_grid( \
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC, \
  KC_TAB,  KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y,    KC_F,    KC_G,    KC_C,    KC_R,    KC_L,    KC_DEL,  \
  KC_RCTL, KC_A,    KC_O,    KC_E,    KC_U,    KC_I,    KC_D,    KC_H,    KC_T,    KC_N,    KC_S,    KC_SLSH, \
  KC_LSFT, KC_SCLN, KC_Q,    KC_J,    KC_K,    KC_X,    KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,    KC_ENT,  \
  KC_ESC,  KC_RALT, KC_LGUI, KC_LALT, LOWER,   KC_SPC,  KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT  \
),

/* Qwerty
 * ,--------------------------------------------------------------------------------------------.
 * |    `   |   1   |   2   |   3   |   4   |  5  |  6  |   7   |   8   |   9   |   0   | Bspc  |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Tab    |   Q   |   W   |   E   |   R   |  T  |  Y  |   U   |   I   |   O   |   P   | Del   |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | R_Ctrl |   A   |   S   |   D   |   F   |  G  |  H  |   J   |   K   |   L   |   ;   |   "   |
 * |--------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Shift  |   Z   |   X   |   C   |   V   |  B  |  N  |   M   |   ,   |   .   |   /   | Enter |
 * |--------+-------+-------+-------+-------+-----+-----+-------+-------+-------+-------+-------|
 * | ESC    | R_Alt |  GUI  |  Alt  | Lower |   Space   | Raise | Left  | Down  |  Up   | Right |
 * `--------------------------------------------------------------------------------------------'
 */
[_QWERTY] = LAYOUT_preonic_grid( \
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC, \
  KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_DEL,  \
  KC_RCTL, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT, \
  KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_ENT,  \
  KC_ESC,  KC_RALT, KC_LGUI, KC_LALT, LOWER,   KC_SPC,  KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT  \
),

/* Lower
 * ,----------------------------------------------------------------------------.
 * |  ~  |  !  |  @  |  #  |  $  |  %  |  ^  |  &   |  *   |  (   |  )   | Bspc |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |  `  |  1  |  2  |  3  |  4  |  5  |  6  |  7   |  8   |  9   |  0   | Del  |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |     | F1  | F2  | F3  | F4  | F5  | F6  |  -   |  =   |  [   |  ]   |  \   |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |     | F7  | F8  | F9  | F10 | F11 | F12 | Home | End  |      |      |      |
 * |-----+-----+-----+-----+-----+-----+-----+------+------+------+------+------|
 * |     |     |     |     |     |           |      | Next | Vol- | Vol+ | Play |
 * `----------------------------------------------------------------------------'
 */
[_LOWER] = LAYOUT_preonic_grid( \
  KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_BSPC, \
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_DEL,  \
  KC_NO,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, KC_BSLS, \
  KC_NO,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_HOME, KC_END,  KC_NO,   KC_NO,   KC_NO,   \
  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   _______, KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY  \
),

/* Raise
 * ,----------------------------------------------------------------------------.
 * |  `  |  1  |  2  |  3  |  4  |  5  |  6  |  7   |  8   |  9   |  0   | Bspc |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |  ~  |  !  |  @  |  #  |  $  |  %  |  ^  |  &   |  *   |  (   |  )   | Del  |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |     | F1  | F2  | F3  | F4  | F5  | F6  |  _   |  +   |  {   |  }   |  |   |
 * |-----+-----+-----+-----+-----+-----|-----+------+------+------+------+------|
 * |     | F7  | F8  | F9  | F10 | F11 | F12 | PgUp | PgDn |      |      |      |
 * |-----+-----+-----+-----+-----+-----+-----+------+------+------+------+------|
 * |     |     |     |     |     |           |      | Next | Vol- | Vol+ | Play |
 * `----------------------------------------------------------------------------'
 */
[_RAISE] = LAYOUT_preonic_grid( \
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_DEL,  \
  KC_TILD, KC_EXLM,   KC_AT, KC_HASH, KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_DEL,  \
  KC_NO,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, KC_PIPE, \
  KC_NO,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_PGUP, KC_PGDN, KC_NO,   KC_NO,   KC_NO,   \
  KC_NO,   KC_NO,   KC_NO,   KC_NO,   _______, KC_NO,   KC_NO,   KC_NO,   KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY  \
),

/* Adjust (Lower + Raise)
 * ,---------------------------------------------------------------------------------------------------.
 * |  F1  | F2     | F3     | F4     | F5     | F6     | F7     | F8     | F9     | F10    | F11 | F12 |
 * |------+--------+--------+--------+--------+--------|--------+--------+--------+--------+-----+-----|
 * |  F1  | F2     | F3     | F4     | F5     | F6     | F7     | F8     | F9     | F10    | F11 | F12 |
 * |------+--------+--------+--------+--------+--------|--------+--------+--------+--------+-----+-----|
 * |      | Reset  |        | Aud on | AudOff | AGnorm | AGswap | Qwerty |        | Dvorak |     |     |
 * |------+--------+--------+--------+--------+--------|--------+--------+--------+--------+-----+-----|
 * |      | Voice- | Voice+ | Mus on | MusOff | MidiOn | MidOff |        |        |        |     |     |
 * |------+--------+--------+--------+--------+--------+--------+--------+--------+--------+-----+-----|
 * |      |        |        |        |        |                 |        |        |        |     |     |
 * `---------------------------------------------------------------------------------------------------'
 */
[_ADJUST] = LAYOUT_preonic_grid( \
  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,    KC_F10,  KC_F11,  KC_F12,  \
  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,    KC_F10,  KC_F11,  KC_F12,  \
  _______, RESET,   MU_MOD,  AU_ON,   AU_OFF,  AG_NORM, AG_SWAP, QWERTY,  _______,  DVORAK,  _______, _______, \
  _______, MUV_DE,  MUV_IN,  MU_ON,   MU_OFF,  MI_ON,   MI_OFF,  _______, _______,  _______, _______, _______, \
  _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______, _______, _______  \
)


};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
        case QWERTY:
          if (record->event.pressed) {
            set_single_persistent_default_layer(_QWERTY);
          }
          return false;
          break;
        case DVORAK:
          if (record->event.pressed) {
            set_single_persistent_default_layer(_DVORAK);
          }
          return false;
          break;
        case LOWER:
          if (record->event.pressed) {
            layer_on(_LOWER);
            update_tri_layer(_LOWER, _RAISE, _ADJUST);
          } else {
            layer_off(_LOWER);
            update_tri_layer(_LOWER, _RAISE, _ADJUST);
          }
          return false;
          break;
        case RAISE:
          if (record->event.pressed) {
            layer_on(_RAISE);
            update_tri_layer(_LOWER, _RAISE, _ADJUST);
          } else {
            layer_off(_RAISE);
            update_tri_layer(_LOWER, _RAISE, _ADJUST);
          }
          return false;
          break;
        case BACKLIT:
          if (record->event.pressed) {
            register_code(KC_RSFT);
            #ifdef BACKLIGHT_ENABLE
              backlight_step();
            #endif
            #ifdef __AVR__
            writePinLow(E6);
            #endif
          } else {
            unregister_code(KC_RSFT);
            #ifdef __AVR__
            writePinHigh(E6);
            #endif
          }
          return false;
          break;
      }
    return true;
};

bool muse_mode = false;
uint8_t last_muse_note = 0;
uint16_t muse_counter = 0;
uint8_t muse_offset = 70;
uint16_t muse_tempo = 50;

void encoder_update_user(uint8_t index, bool clockwise) {
  if (muse_mode) {
    if (IS_LAYER_ON(_RAISE)) {
      if (clockwise) {
        muse_offset++;
      } else {
        muse_offset--;
      }
    } else {
      if (clockwise) {
        muse_tempo+=1;
      } else {
        muse_tempo-=1;
      }
    }
  } else {
    if (clockwise) {
      register_code(KC_PGDN);
      unregister_code(KC_PGDN);
    } else {
      register_code(KC_PGUP);
      unregister_code(KC_PGUP);
    }
  }
}

void dip_switch_update_user(uint8_t index, bool active) {
    switch (index) {
        case 0:
            if (active) {
                layer_on(_ADJUST);
            } else {
                layer_off(_ADJUST);
            }
            break;
        case 1:
            if (active) {
                muse_mode = true;
            } else {
                muse_mode = false;
            }
    }
}


void matrix_scan_user(void) {
#ifdef AUDIO_ENABLE
    if (muse_mode) {
        if (muse_counter == 0) {
            uint8_t muse_note = muse_offset + SCALE[muse_clock_pulse()];
            if (muse_note != last_muse_note) {
                stop_note(compute_freq_for_midi_note(last_muse_note));
                play_note(compute_freq_for_midi_note(muse_note), 0xF);
                last_muse_note = muse_note;
            }
        }
        muse_counter = (muse_counter + 1) % muse_tempo;
    } else {
        if (muse_counter) {
            stop_all_notes();
            muse_counter = 0;
        }
    }
#endif
}

bool music_mask_user(uint16_t keycode) {
  switch (keycode) {
    case RAISE:
    case LOWER:
      return false;
    default:
      return true;
  }
}