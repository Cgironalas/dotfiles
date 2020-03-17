# Anne Pro 2 Configurations

## Configuration Files

All files follow the JSON format of being a dictionary with the keys of:

* `data`: Contains the configuration of every possible layer.
* `crc`: Obins given value.
* `model`: Obins given value.
* `type`: "layout".
* `name`: name shown in the ObinsKit program.
* `device`: Obins given value.

### Data layers

The data section of the configuration will show what keys are set to what numeric values in every possible layer. The layers being the following:

* `taps`: Tap layer, the values will be triggered when the key is pressed and promptly released. In the ObinsKit it is possible to configure at what point will the tap 'timeout' and also if its possible to tap more than one key at a time (if set to false if more than one key is in the 'pressed' state, the tap layer will be skipped).
* `layer2`: Layer triggered by FN2 modifier.
* `layer1`: Layer triggered by FN1 modifier.
* `layer0`: default/base layer for the keyboard.


### Notes

* ObinsKit makes any `FN` key trigger set to any `layer#` be replicated in all `layer#` layers. Not sure if there is a workaround to this.
* It is possible to have an `FN` modifier within layers 1 & 2, but it will be ignored by the already triggered `FN` modifier.

## Current Configuration

The current configuration that I'm running on the Anne Pro 2:

### Base Layer Summary

* `~` key hard coded on the top left (instead of `ESC`).
* `Right Control` in place of `Caps Lock`.
* `FN1` trigger key on the bottom left (instead of `Left Control`).
* Four bottom right most keys as hard coded VIM arrow keys (`Left`, `Down`, `Up`, `Right`).
* Everything else stays the same.

### FN1 Layer

* TKL keys as:
 * `Escape` at top left.
 * `F1 - F12` in the R4 keys except the edges (`0` -> `=+`).

 * Arrow keys as VIM arrow keys shifted one key to the right `JKL:` instead of `HJLK`.

 * `Delete` on Backspace.
 * `Print Screen` on `\|`.
 * `Home` on `U`.
 * `End` on `M`.
 * `Page Up` on `I`.
 * `Page Down` on `<`.

* Media Control Keys as:
 * `Previous Track` on `Q`.
 * `Play/Pause` on `W`.
 * `Next Track` on `E`.

* Volume control as:
 * `Mute` on `A`.
 * `Lower volume` on `S`.
 * `Raise valme` on `D`.

* Bluetooth connection triggers as:
 * `Bluetooth 1` on `Z`.
 * `Bluetooth 2` on `X`.
 * `Bluetooth 3` on `C`.
 * `Bluetooth 4` on `V`.

* Anne Pro tools:
 * Bluetooth battery indicator on `'`.
 * Increase backlight intensity on `]`.
 * Decrease backlight intensity on `[`.

### FN2 Layer

No keys are manually set here.

### Tap Layer

* `ESC` is in `Caps Lock`.
* No other tap layer keys set.
