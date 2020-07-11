#include QMK_KEYBOARD_H


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
#define _DVORAK 0
#define _QWERTY 1
#define _LOWER 3
#define _RAISE 4
#define _FN 5
#define _ADJUST 16

enum custom_keycodes {
  DVORAK = SAFE_RANGE,
  QWERTY,
  LOWER,
  RAISE,
  ADJUST,
  FN
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Dvorak
 * ,------------------------------------------------------------------------------------------------.
 * | Tab        |   "   |   ,   |   .   |   P   |  Y  |  F  |   G   |   C   |   R   |   L   | Bksp  |
 * |------------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | R_Ctrl/ESC |   A   |   O   |   E   |   U   |  I  |  D  |   H   |   T   |   N   |   S   |   /   |
 * |------------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Shift      |   ;   |   Q   |   J   |   K   |  X  |  B  |   M   |   W   |   V   |   Z   | Enter |
 * |------------+-------+-------+-------+-------+-----+-----+-------+-------+-------+-------+-------|
 * | FN         | R_Alt |  GUI  |  Alt  | Lower |   Space   | Raise | Left  | Down  |  Up   | Right |
 * `------------------------------------------------------------------------------------------------'
 */
[_DVORAK] = LAYOUT_ortho_4x12( \
  KC_TAB,       KC_QUOT, KC_COMM, KC_DOT,  KC_P,    KC_Y,    KC_F,    KC_G,    KC_C,    KC_R,    KC_L,    KC_BSPC, \
  RCTL(KC_ESC), KC_A,    KC_O,    KC_E,    KC_U,    KC_I,    KC_D,    KC_H,    KC_T,    KC_N,    KC_S,    KC_SLSH, \
  KC_LSFT,      KC_SCLN, KC_Q,    KC_J,    KC_K,    KC_X,    KC_B,    KC_M,    KC_W,    KC_V,    KC_Z,    KC_ENT,  \
  FN,           KC_RALT, KC_LGUI, KC_LALT, LOWER,   KC_SPC,  KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT  \
),

/* Qwerty
 * ,------------------------------------------------------------------------------------------------.
 * | Tab        |   Q   |   W   |   E   |   R   |  T  |  Y  |   U   |   I   |   O   |   P   | Bksp  |
 * |------------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | R_Ctrl/ESC |   A   |   S   |   D   |   F   |  G  |  H  |   J   |   K   |   L   |   ;   |   "   |
 * |------------+-------+-------+-------+-------+-----|-----+-------+-------+-------+-------+-------|
 * | Shift      |   Z   |   X   |   C   |   V   |  B  |  N  |   M   |   ,   |   .   |   /   | Enter |
 * |------------+-------+-------+-------+-------+-----+-----+-------+-------+-------+-------+-------|
 * | FN         | R_Alt |  GUI  |  Alt  | Lower |   Space   | Raise | Left  | Down  |  Up   | Right |
 * `------------------------------------------------------------------------------------------------'
 */
[_QWERTY] = LAYOUT_ortho_4x12( \
  KC_TAB,       KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC, \
  RCTL(KC_ESC), KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT, \
  KC_LSFT,      KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_ENT,  \
  FN,           KC_RALT, KC_LGUI, KC_LALT, LOWER,   KC_SPC,  KC_SPC,  RAISE,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT  \
),

/* FN
 * ,----------------------------------------------------------------------------------.
 * |     | Mute | Vol- | Vol+ |      |      |      | Home | PgUp | RGB- | RGB+ | PS   |
 * |-----+------+------+------+------+------|------+------+------+------+------+------|
 * |     | Prev | Play | Next | MsB1 | MsUp | MsB2 | Left | Down |  Up  | Down |      |
 * |-----+------+------+------+------+------|------+------+------+------+------+------|
 * |     |      |      |      | MsLf | MsDn | MsRg | End  | PgDn |      | RGBt |      |
 * |-----+------+------+------+------+------+------+------+------+------+------+------|
 * |     |      |      |      |      |             |      |      |      |      |      |
 * `----------------------------------------------------------------------------------'
 */
[_FN] = LAYOUT_preonic_grid( \
  _______, KC_MUTE, KC_VOLD, KC_VOLU, _______, _______, _______, KC_HOME, KC_PGUP, BL_DEC,  BL_INC,  KC_PSCR, \
  _______, KC_MPRV, KC_MPLY, KC_MNXT, KC_BTN1, KC_MS_U, KC_BTN2, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, _______, \
  _______, _______, _______, _______, KC_MS_L, KC_MS_D, KC_MS_R, KC_END,  KC_PGDN, _______, BL_TOGG, _______, \
  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______  \
),

/* Lower
 * ,-----------------------------------------------------------------------------------.
 * |   `  |   1  |   2  |   3  |   4  |   5  |   6  |   7  |   8  |   9  |   0  | Del  |
 * |------+------+------+------+------+-------------+------+------+------+------+------|
 * |      |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |   -  |   =  |   [  |   ]  |  \   |
 * |------+------+------+------+------+------|------+------+------+------+------+------|
 * |      |  F7  |  F8  |  F9  |  F10 |  F11 |  F12 |      |      |      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |      |      |      |      |             |ADJUST|      |      |      |      |
 * `-----------------------------------------------------------------------------------'
 */
[_LOWER] = LAYOUT_ortho_4x12( \
  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_DEL,  \
  _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, KC_BSLS, \
  _______, KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, _______, _______, _______, _______, \
  _______, _______, _______, _______, _______, _______, _______, ADJUST,  _______, _______, _______, _______  \
),

/* Raise
 * ,-----------------------------------------------------------------------------------.
 * |   ~  |   !  |   @  |   #  |   $  |   %  |   ^  |   &  |   *  |   (  |   )  | Del  |
 * |------+------+------+------+------+-------------+------+------+------+------+------|
 * |      |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |   _  |   +  |   {  |   }  |  |   |
 * |------+------+------+------+------+------|------+------+------+------+------+------|
 * |      |  F7  |  F8  |  F9  |  F10 |  F11 |  F12 |      |      |      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |      |      |      |Adjust|             |      |      |      |      |      |
 * `-----------------------------------------------------------------------------------'
 */
[_RAISE] = LAYOUT_ortho_4x12( \
  KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_DEL,  \
  _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, KC_PIPE, \
  _______, KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, _______, _______, _______, _______, \
  _______, _______, _______, _______, ADJUST,  _______, _______, _______, _______, _______, _______, _______  \
),

/* Adjust (Lower + Raise)
 * ,-----------------------------------------------------------------------------------.
 * |      | RESET|      |      |      |      |      |      |      |      |      |  Del |
 * |------+------+------+------+------+-------------+------+------+------+------+------|
 * |      |      |      |Aud on|Audoff|AGnorm|AGswap|Qwerty|      |Dvorak|      |      |
 * |------+------+------+------+------+------|------+------+------+------+------+------|
 * |      |      |      |      |      |      |      |      |      |      |      |      |
 * |------+------+------+------+------+------+------+------+------+------+------+------|
 * |      |      |      |      |      |             |      |      |      |      |RGBMOD|
 * `-----------------------------------------------------------------------------------'
 */
[_ADJUST] =  LAYOUT_ortho_4x12( \
  _______, RESET,   _______, _______, _______, _______, _______, _______, _______, _______, _______, KC_DEL,  \
  _______, _______, _______, AU_ON,   AU_OFF,  AG_NORM, AG_SWAP, QWERTY,  _______, DVORAK,  _______, _______, \
  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, \
  _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, RGB_MOD  \
)


};


void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case DVORAK:
      if (record->event.pressed) {
        set_single_persistent_default_layer(_DVORAK);
        persistent_default_layer_set(1UL<<_DVORAK);
      }
      return false;
      break;
    case QWERTY:
      if (record->event.pressed) {
        set_single_persistent_default_layer(_QWERTY);
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
    case FN:
      if (record->event.pressed) {
        layer_on(_FN);
        update_tri_layer(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_FN);
        update_tri_layer(_LOWER, _RAISE, _ADJUST);
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
    case ADJUST:
      if (record->event.pressed) {
        layer_on(_ADJUST);
      } else {
        layer_off(_ADJUST);
      }
      return false;
      break;
  }
  return true;
}

#ifdef RGBLIGHT_ENABLE
bool rgb_layer_change = true;
#endif

uint32_t layer_state_set_user(uint32_t state) {
#ifdef RGBLIGHT_ENABLE
  uint8_t default_layer = eeconfig_read_default_layer();
  if (rgb_layer_change) {
    switch (biton32(state)) {
    case _RAISE:
      /* rgblight_sethsv(HSV_RED); */
      /* rgblight_mode(1); */
      break;
    case _LOWER:
      /* rgblight_sethsv(HSV_GREEN); */
      /* rgblight_mode(1); */
      break;
    case _ADJUST:
      /* rgblight_sethsv(HSV_YELLOW); */
      /* rgblight_mode(1); */
      break;
    default:
      if (default_layer & (1UL << _DVORAK)) {
        rgblight_sethsv(HSV_CYAN);
      }
      else {
        rgblight_sethsv(HSV_BLUE);
      }
      rgblight_mode(1);
      break;
    }
  }
#endif
  return state;
}
