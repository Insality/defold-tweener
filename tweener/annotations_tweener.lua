---Download Defold annotations from here: https://github.com/astrochili/defold-annotations/releases/

---@alias easing_function (fun(current: number, from: number, to: number, time: number): number)|constant|number[]

---@class tweener
---@field tween fun(easing_function: easing_function, from: number, to: number, time: number, callback: fun(value: number, is_end: boolean), update_delta_time: number|nil): hash
---@field ease fun(easing_function: easing_function, from: number, to: number, time: number, time_elapsed: number): number