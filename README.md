![](media/logo.png)

[![GitHub release (latest by date)](https://img.shields.io/github/v/tag/insality/defold-tweener?style=for-the-badge&label=Release)](https://github.com/Insality/defold-tweener/tags)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/insality/defold-tweener/ci_workflow.yml?style=for-the-badge)](https://github.com/Insality/defold-tweener/actions)
[![codecov](https://img.shields.io/codecov/c/github/Insality/defold-tweener?style=for-the-badge)](https://codecov.io/gh/Insality/defold-tweener)

[![Github-sponsors](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/insality) [![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/insality) [![BuyMeACoffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/insality)


# Tweener

**Tweener** - is a single file Lua module for the [Defold](https://defold.com/) game engine. It provides a way to handle manual tweening in your game.

## Features

- **Tweening**: Create tweens for any action your want.
- **Easing Functions**: Provides a set of easing functions for different types of easings.
- **Custom Update Frequency**: Option to define update frequency for the tween.
- **Callbacks**: Callbacks for each tween update.
- **Custom Easings**: Support for custom easing functions.

## Setup

### [Dependency](https://www.defold.com/manuals/libraries/)

Open your `game.project` file and add the following line to the dependencies field under the project section:

**[Tweener](https://github.com/Insality/defold-tweener/archive/refs/tags/3.zip)**

```
https://github.com/Insality/defold-tweener/archive/refs/tags/3.zip
```

### Library Size

> **Note:** The library size is calculated based on the build report per platform

| Platform         | Library Size |
| ---------------- | ------------ |
| HTML5            | **3.28 KB**  |
| Desktop / Mobile | **6.21 KB**  |


### Global Update Frequency

Optionally, you can setup global default update frequency in your game.project. It's `60` by default.

Add next `tweener` section to your `game.project` in text mode:

```ini
[tweener]
update_frequency = 60
```

## API Reference

### Quick API Reference

```lua
-- Tween function can be a string, a predefined easing function, or a custom easing function
local tween_function = "linear" or tweener.linear or go.EASING_LINEAR or gui.EASING_LINEAR or {0, 0.2, 0.4, 0.8, 0.9, 1}

tweener.tween(tween_function, from, to, time, callback, [dt])
tweener.ease(tween_function, from, to, time, time_elapsed)
```

### Importing the Module

To start using the Tweener module in your project, you first need to import it. This can be done with the following line of code:

```lua
local tweener = require("tweener.tweener")
```

### Functions

The Tweener module provides two primary functions to work with tweens:

**tweener.tween**
---
```lua
tweener.tween(tween_function, from, to, time, callback, [dt])
```

This function initiates a tween operation immediately. Here's how to use it:

- **Parameters:**
  - `tween_function`: The tween function. You can use one of the predefined easing functions or provide a custom one.
  - `from`: The starting value of the tween.
  - `to`: The ending value of the tween.
  - `time`: The duration of the tween, in seconds.
  - `callback`: A `function(value, is_final_call)` that gets called upon each update of the tween.
  - `dt` (optional): The time interval for updating the tween, in seconds.

- **Return Value:**
  - `tweener_id`: A tweener id from `timer.delay` if you wish to cancel the tween.

- **Usage Example:**

```lua
tweener.tween(tweener.linear, 0, 100, 1.5, function(value, is_final_call)
	print("Tween value: " .. value)
end)

tweener.tween(go.EASING_OUTSINE, 0, 100, 1.5, function(value, is_final_call)
	print("Tween value: " .. value)
end)

local tween_id = tweener.tween({0, 0.2, 0.4, 0.8, 0.9, 1}, 0, 100, 1.5, function(value, is_final_call)
	print("Tween value: " .. value)
end)

-- You can cancel the tween by calling tweener.cancel
tweener.cancel(tween_id)
```


**tweener.ease**
---
```lua
tweener.ease(tween_function, from, to, time, time_elapsed)
```

This function calculates the value of the tween at a specific point in time, based on the easing function provided.

- **Parameters:**
  - `tween_function`: The tween function.
  - `from`: The starting value of the tween.
  - `to`: The ending value of the tween.
  - `time`: The total duration of the tween, in seconds.
  - `time_elapsed`: The elapsed time since the start of the tween, in seconds.

- **Usage Example:**

```lua
local value = tweener.ease(tweener.inquad, 0, 100, 1.5, 0.75)
print("The tween value at halfway point is: ", value)

local value = tweener.ease(gui.EASING_OUTSINE, 0, 100, 1.5, 0.75)
print("The tween value at halfway point is: ", value)

local value = tweener.ease({0, 0.2, 0.4, 0.8, 0.9, 1}, 0, 100, 1.5, 0.75)
print("The tween value at halfway point is: ", value)
```

These functions provide a flexible and powerful way to add animations and transitions to your projects, making them feel more dynamic and engaging. Enjoy animating with the **Tweener** module! *(Thanks, Mister ChatGPT)* 🙃


## Tween Functions

| Tweener Constant | Defold Constant | Easing |
|------------------|-----------------|--------|
| `tweener.linear` | `go.EASING_LINEAR` | <img src="media/easing_icons/linear.png" width="50" height="50"> |
| `tweener.insine` | `go.EASING_INSINE` | <img src="media/easing_icons/insine.png" width="50" height="50"> |
| `tweener.inquad` | `go.EASING_INQUAD` | <img src="media/easing_icons/inquad.png" width="50" height="50"> |
| `tweener.incubic` | `go.EASING_INCUBIC` | <img src="media/easing_icons/incubic.png" width="50" height="50"> |
| `tweener.incirc` | `go.EASING_INCIRC` | <img src="media/easing_icons/incirc.png" width="50" height="50"> |
| `tweener.inquart` | `go.EASING_INQUART` | <img src="media/easing_icons/inquart.png" width="50" height="50"> |
| `tweener.inquint` | `go.EASING_INQUINT` | <img src="media/easing_icons/inquint.png" width="50" height="50"> |
| `tweener.inexpo` | `go.EASING_INEXPO` | <img src="media/easing_icons/inexpo.png" width="50" height="50"> |
| `tweener.inback` | `go.EASING_INBACK` | <img src="media/easing_icons/inback.png" width="50" height="50"> |
| `tweener.inelastic` | `go.EASING_INELASTIC` | <img src="media/easing_icons/inelastic.png" width="50" height="50"> |
| `tweener.inbounce` | `go.EASING_INBOUNCE` | <img src="media/easing_icons/inbounce.png" width="50" height="50"> |
| `tweener.outsine` | `go.EASING_OUTSINE` | <img src="media/easing_icons/outsine.png" width="50" height="50"> |
| `tweener.outquad` | `go.EASING_OUTQUAD` | <img src="media/easing_icons/outquad.png" width="50" height="50"> |
| `tweener.outcubic` | `go.EASING_OUTCUBIC` | <img src="media/easing_icons/outcubic.png" width="50" height="50"> |
| `tweener.outcirc` | `go.EASING_OUTCIRC` | <img src="media/easing_icons/outcirc.png" width="50" height="50"> |
| `tweener.outquart` | `go.EASING_OUTQUART` | <img src="media/easing_icons/outquart.png" width="50" height="50"> |
| `tweener.outquint` | `go.EASING_OUTQUINT` | <img src="media/easing_icons/outquint.png" width="50" height="50"> |
| `tweener.outexpo` | `go.EASING_OUTEXPO` | <img src="media/easing_icons/outexpo.png" width="50" height="50"> |
| `tweener.outback` | `go.EASING_OUTBACK` | <img src="media/easing_icons/outback.png" width="50" height="50"> |
| `tweener.outelastic` | `go.EASING_OUTELASTIC` | <img src="media/easing_icons/outelastic.png" width="50" height="50"> |
| `tweener.outbounce` | `go.EASING_OUTBOUNCE` | <img src="media/easing_icons/outbounce.png" width="50" height="50"> |
| `tweener.inoutsine` | `go.EASING_INOUTSINE` | <img src="media/easing_icons/inoutsine.png" width="50" height="50"> |
| `tweener.inoutquad` | `go.EASING_INOUTQUAD` | <img src="media/easing_icons/inoutquad.png" width="50" height="50"> |
| `tweener.inoutcubic` | `go.EASING_INOUTCUBIC` | <img src="media/easing_icons/inoutcubic.png" width="50" height="50"> |
| `tweener.inoutcirc` | `go.EASING_INOUTCIRC` | <img src="media/easing_icons/inoutcirc.png" width="50" height="50"> |
| `tweener.inoutquart` | `go.EASING_INOUTQUART` | <img src="media/easing_icons/inoutquart.png" width="50" height="50"> |
| `tweener.inoutquint` | `go.EASING_INOUTQUINT` | <img src="media/easing_icons/inoutquint.png" width="50" height="50"> |
| `tweener.inoutexpo` | `go.EASING_INOUTEXPO` | <img src="media/easing_icons/inoutexpo.png" width="50" height="50"> |
| `tweener.inoutback` | `go.EASING_INOUTBACK` | <img src="media/easing_icons/inoutback.png" width="50" height="50"> |
| `tweener.inoutelastic` | `go.EASING_INOUTELASTIC` | <img src="media/easing_icons/inoutelastic.png" width="50" height="50"> |
| `tweener.inoutbounce` | `go.EASING_INOUTBOUNCE` | <img src="media/easing_icons/inoutbounce.png" width="50" height="50"> |
| `tweener.outinsine` | `go.EASING_OUTINSINE` | <img src="media/easing_icons/outinsine.png" width="50" height="50"> |
| `tweener.outinquad` | `go.EASING_OUTINQUAD` | <img src="media/easing_icons/outinquad.png" width="50" height="50"> |
| `tweener.outincubic` | `go.EASING_OUTINCUBIC` | <img src="media/easing_icons/outincubic.png" width="50" height="50"> |
| `tweener.outincirc` | `go.EASING_OUTINCIRC` | <img src="media/easing_icons/outincirc.png" width="50" height="50"> |
| `tweener.outinquart` | `go.EASING_OUTINQUART` | <img src="media/easing_icons/outinquart.png" width="50" height="50"> |
| `tweener.outinquint` | `go.EASING_OUTINQUINT` | <img src="media/easing_icons/outinquint.png" width="50" height="50"> |
| `tweener.outinexpo` | `go.EASING_OUTINEXPO` | <img src="media/easing_icons/outinexpo.png" width="50" height="50"> |
| `tweener.outinback` | `go.EASING_OUTINBACK` | <img src="media/easing_icons/outinback.png" width="50" height="50"> |
| `tweener.outinelastic` | `go.EASING_OUTINELASTIC` | <img src="media/easing_icons/outinelastic.png" width="50" height="50"> |
| `tweener.outinbounce` | `go.EASING_OUTINBOUNCE` | <img src="media/easing_icons/outinbounce.png" width="50" height="50"> |


## Usage

You can use Tweener to animate scoring text, for example:

<img src="media/tween_text.gif" width="300">

This animation can be created using the following code:

```lua
tweener.tween(gui.EASING_OUTCIRC, 0, 9999, 2.4, function(value, is_final_call)
	gui.set_text(text_score, "Score: " .. math.floor(value))

	if is_final_call then
		gui.set_scale(text_score, vmath.vector3(1.25, 1.25, 1))
		gui.animate(text_score, "scale", vmath.vector3(1, 1, 1), gui.EASING_OUTBOUNCE, 0.5)
	end
end)
```

You can obtain the value of the tween at any point in time with the `tweener.ease` function:

```lua
tweener.ease(gui.EASING_OUTSINE, 0, 100, 1, 0)    -- Returns 0
tweener.ease(gui.EASING_OUTSINE, 0, 100, 1, 0.25) -- Returns 38.268343236509
tweener.ease(gui.EASING_OUTSINE, 0, 100, 1, 0.5)  -- Returns 70.710678118655
tweener.ease(gui.EASING_OUTSINE, 0, 100, 1, 0.75) -- Returns 92.387953251129
tweener.ease(gui.EASING_OUTSINE, 0, 100, 1, 1)    -- Returns 100
```


## License

This project is licensed under the MIT License - see the LICENSE file for details.


## Issues and suggestions

If you have any issues, questions or suggestions please [create an issue](https://github.com/Insality/defold-tweener/issues).


## 👏 Contributors

<a href="https://github.com/Insality/defold-tweener/graphs/contributors">
  <img src="https://contributors-img.web.app/image?repo=insality/defold-tweener"/>
</a>


## Changelog

### **V1**
<details>
	<summary><b>Changelog</b></summary>

	- Initial release
</details>


### **V2**
<details>
	<summary><b>Changelog</b></summary>

	- Changed timer `delta time` to `socket.gettime` for more precise tweening
</details>


### **V3**
<details>
	<summary><b>Changelog</b></summary>

	- Added custom easings support
</details>


## ❤️ Support project ❤️

Your donation helps me stay engaged in creating valuable projects for **Defold**. If you appreciate what I'm doing, please consider supporting me!

[![Github-sponsors](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/insality) [![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/insality) [![BuyMeACoffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/insality)
