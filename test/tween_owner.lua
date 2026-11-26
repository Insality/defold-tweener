---Shared state of the tween owner scripts: the tests read how the tweens run in the .script and .gui_script contexts
local M = {
	script = { count = 0, last_value = nil, is_end = false },
	gui = { count = 0, last_value = nil, is_end = false },
}

return M
