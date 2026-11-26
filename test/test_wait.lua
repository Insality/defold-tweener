---Pause the running deftest coroutine for frames. The test continues in the `update` of the test script, after the frame timers
local M = {}

local waiting_coroutine = nil


---Wait for the next frames
---@param count number|nil Default is 1
function M.frames(count)
	for _ = 1, count or 1 do
		waiting_coroutine = coroutine.running()
		coroutine.yield()
	end
end


---Wait frames until the condition is true or the timeout is reached
---@param condition fun(): boolean
---@param timeout number|nil Seconds, default is 2
---@return boolean is_reached
function M.until_true(condition, timeout)
	local end_time = socket.gettime() + (timeout or 2)
	while not condition() do
		if socket.gettime() > end_time then
			return false
		end
		M.frames(1)
	end

	return true
end


---Wait frames for the time in seconds
---@param seconds number
function M.seconds(seconds)
	local end_time = socket.gettime() + seconds
	while socket.gettime() < end_time do
		M.frames(1)
	end
end


---Call from the test script update
function M.update()
	if not waiting_coroutine then
		return
	end

	local co = waiting_coroutine
	waiting_coroutine = nil
	local is_ok, error_message = coroutine.resume(co)
	if not is_ok then
		print("Test coroutine error", error_message)
		os.exit(1)
	end
end


return M
