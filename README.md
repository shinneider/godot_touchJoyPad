# Godot Touch Joy Pad

# Install:

1. Manual Mode.

   1. Create `plugins` folder in project root.
   1. Download this repo and put all files inside a `touchJoyPad` folder (inside a `plugins` folder).
   1. Use `touchJoyPad.tscn` scene in your project.

1. Git Mode.
   1. if you not started git repo before, start it `git init`
   1. in first time `git submodule add https://github.com/shinneider/godot_touchJoyPad.git ./plugins/touchJoyPad`
   1. in next repo clone, clone normally, after clone, run `git submodule update --init --recursive`

# Configuration:

1. Basic configuration.

   1. Arguments.
      `After import scene check Inspector tab of Godot` <br />
      1. Left Pad Style:
         Select `tipe of Joy`, a classical `D-Pad` or a modern `Analog`.
      1. Map Analog to DPad:
         Analog send analogic signal(between -1 and 1), but if set this, the `signal is converted` to natives `ui_left`, `ui_up`, `ui_right` and `ui_down` signal (if you need, is possible to receive analog singal too).
      1. Visible Only Touchscreen:
         Visible `only` in `devices with touch` capabilities.
      1. Analog Tap To Show:
         This `show the analog` just if `user tap in the screen`.

1. Receive Analog movimentation.
   - The touchJoyPad is attached to the group Joystick [see this](https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html#groups)
   - On each Analog movimentation ths function `analog_signal_change` is fired. The func `analog_signal_change` analog_signal_change `analogPosition` and `analogName`.
   - The `analogPosition` `argument` is x,y `Analog coordinates` (x and y contains `values between -1 and 1`) being that `x < 0` is moving to the `left`, `x > 0` moving to `right`, `y < 0` moving `down`, `y > 0` moving to `up`, and finally `x = 0 and y = 0` `isn't moving`.
   - The `analogName` `argument` is way to `filter Analog signal` if you decide to `re-use` the Analog scene (`Ex: two analog in screen`, left for movimentation and right for aim).
   - Ex: `analog_signal_change` implementation.
     ```
     func analog_signal_change(analogPosition, analogName):
        # When to move Analog, send signal to natives ui signal
        # but implements a dead zone in 20% in the curso of Analog
        # This is good for to avoid user mistakes in move hand
        Input.action_press("ui_left") if analogPosition.x < -0.2 else Input.action_release("ui_left")
        Input.action_press("ui_right") if analogPosition.x > 0.2 else Input.action_release("ui_right")
        Input.action_press("ui_down") if analogPosition.y < -0.2 else Input.action_release("ui_down")
        Input.action_press("ui_up") if analogPosition.y > 0.2 else Input.action_release("ui_up")
     ```
1. Analog Tap To Show.

   - If you `need to use this`, you need to `put de scene inside` a `ViewportContainer` or a `error occurs` and `not compile`.
   - This `occurs because` the `ViewportContainer` is `used to determine a area` of `Tap To Show`.
   - Ex: `two Analog`, `one in each corner` of the screen, the `ViewportContainer` `determines area of each Analog`, without this all screen active the two analogs

1. Obs in standalone use of `DPad` or `Analog`.

   1. If you need to `use manually` the plugins, `you need to implement logic` for this cases:
      - `Hide` (Because `enable = false`, `mantains the touch area`, `i sugest` move button for out of the screen `position = Vector2(-1000, -1000)`).
      - `Hide if touch device` (Check if touch device using `OS.has_touchscreen_ui_hint()`).
      - `Pass the param AnalogTapToShowContainer` (Used for the Analog in Tap To Show) `for default he search ViewportContainer in up parent`, but if you need, just specify a parent for her (Ex: `$"leftPad/JoyStickLeft".AnalogTapToShowContainer = get_parent()`).

1. Help in Test/Debug.
   - to help in your test in desktop without touchscreen, enable godot touch emulator.
   - Go to `Project Settings`, on the left menu search `Pointing` inside `Input Devices`.
   - Enable `Emulate Touch From Mouse`, on this enable, mouse is used as touch on the screen.

# Images:

Using D-Pad:
![dpad](https://user-images.githubusercontent.com/30196992/92304229-fe015880-ef73-11ea-8120-beacaa78294e.png)

D-Pad Pressed:
![dpad](https://user-images.githubusercontent.com/30196992/92304254-28ebac80-ef74-11ea-801e-3527085a580a.png)

Using Analog:
![Analog](https://user-images.githubusercontent.com/30196992/92304218-e1652080-ef73-11ea-92ac-f13773f30432.png)

Using Analog with tap to show:
![tapToShow](https://user-images.githubusercontent.com/30196992/92304186-8d5a3c00-ef73-11ea-93ec-fe3e1c842711.png)

# Credits

- [kubecz3k](https://godotengine.org/qa/user/kubecz3k) First version of code analog.
- [gswashburn](https://godotengine.org/qa/user/gswashburn) Port code analog to Godot 3.
- [kenney.kl](https://www.kenney.nl/assets/onscreen-controls) Art for analog and D-Pad.
