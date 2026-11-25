local test_wait = require("test.test_wait")
local tween_owner = require("test.tween_owner")

---Start a tween and record each callback call
---@return table record { tween: tween, calls: table[] }
local function record_tween(tweener, easing, from, to, time, update_delta_time)
	local record = { calls = {} }
	record.tween = tweener.tween(easing, from, to, time, function(value, is_end, time_elapsed, time_total)
		table.insert(record.calls, { value = value, is_end = is_end, time_elapsed = time_elapsed, time_total = time_total })
	end, update_delta_time)

	return record
end


return function()
	---@type tweener
	---@diagnostic disable-next-line: missing-fields
	local tweener = {}

	describe("Defold Tweener", function()
		before(function()
			tweener = require("tweener.tweener")
		end)

		it("Tweener Ease", function()
			assert(tweener.ease(go.EASING_LINEAR, 0, 100, 1, 0) == 0)
			assert(tweener.ease(go.EASING_LINEAR, 0, 100, 1, 0.5) == 50)
			assert(tweener.ease(go.EASING_LINEAR, 0, 100, 1, 1) == 100)

			assert(tweener.ease(go.EASING_INOUTQUAD, 0, 100, 1, 0) == 0)
			assert(tweener.ease(go.EASING_INOUTQUAD, 0, 100, 1, 0.5) == 50)
			assert(tweener.ease(go.EASING_INOUTQUAD, 0, 100, 1, 1) == 100)
		end)

		it("Tweener Custom Ease", function()
			local easing = {0, 1, 2, 1, 0}

			assert(tweener.ease(easing, 0, 100, 1, 0) == 0)
			assert(tweener.ease(easing, 0, 100, 1, 0.25) == 100)
			assert(tweener.ease(easing, 0, 100, 1, 0.5) == 200)
			assert(tweener.ease(easing, 0, 100, 1, 0.75) == 100)
			assert(tweener.ease(easing, 0, 100, 1, 1) == 0)

			-- Edge
			assert(tweener.ease(easing, 0, 100, 1, -1) == 0)
			assert(tweener.ease(easing, 0, 100, 1, 0) == 0)
			assert(tweener.ease(easing, 0, 100, 1, 2) == 0)

			-- Non from zero
			assert(tweener.ease(easing, 100, 200, 1, 0) == 100)
			assert(tweener.ease(easing, 100, 200, 1, 0.25) == 200)
			assert(tweener.ease(easing, 100, 200, 1, 0.5) == 300)
			assert(tweener.ease(easing, 100, 200, 1, 0.75) == 200)
			assert(tweener.ease(easing, 100, 200, 1, 1) == 100)
		end)

		it("Tweener should support each Defold tweening", function()
			local epsilon = 0.0001
			assert(tweener.ease(go.EASING_INBACK, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INBOUNCE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INCIRC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INCUBIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INELASTIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INEXPO, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTBACK, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTBOUNCE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTCIRC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTCUBIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTELASTIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTEXPO, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTQUAD, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTQUART, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTQUINT, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INOUTSINE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INQUAD, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INQUART, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INQUINT, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_INSINE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_LINEAR, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTBACK, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTBOUNCE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTCIRC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTCUBIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTELASTIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTEXPO, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINBACK, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINBOUNCE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINCIRC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINCUBIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINELASTIC, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINEXPO, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINQUAD, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINQUART, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINQUINT, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTINSINE, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTQUAD, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTQUART, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTQUINT, 0, 1, 1, 0) < epsilon)
			assert(tweener.ease(go.EASING_OUTSINE, 0, 1, 1, 0) < epsilon)
		end)

		it("Tween can be cancelled", function()
			local tween = tweener.tween(go.EASING_LINEAR, 0, 100, 1, function() end)
			assert(tweener.is_active(tween))
			tweener.cancel(tween)
			assert(not tweener.is_active(tween))
		end)

		it("Tween can be paused", function()
			local tween = tweener.tween(go.EASING_LINEAR, 0, 100, 1, function() end)
			assert(tweener.is_active(tween))
			tweener.set_pause(tween, true)
			assert(tweener.is_paused(tween))
		end)

		it("Tween can be resumed", function()
			local tween = tweener.tween(go.EASING_LINEAR, 0, 100, 1, function() end)
			assert(tweener.is_active(tween))
			tweener.set_pause(tween, true)
			assert(tweener.is_paused(tween))
			tweener.set_pause(tween, false)
			assert(not tweener.is_paused(tween))
		end)

		it("Tween can be checked if it is active", function()
			local tween = tweener.tween(go.EASING_LINEAR, 0, 100, 1, function() end)
			assert(tweener.is_active(tween))
			tweener.cancel(tween)
			assert(not tweener.is_active(tween))
		end)

		it("Tween updates on timer ticks and reaches the final value exactly", function()
			local easings = { go.EASING_LINEAR, go.EASING_OUTSINE, "inoutquad", { 0, 0.3, 1 }, tweener.outback }
			local records = {}
			for index = 1, #easings do
				records[index] = record_tween(tweener, easings[index], 10, 110, 0.1)
				assert(#records[index].calls == 0)
			end

			assert(test_wait.until_true(function()
				for index = 1, #records do
					if tweener.is_active(records[index].tween) then
						return false
					end
				end
				return true
			end))

			for index = 1, #records do
				local calls = records[index].calls
				local last_call = calls[#calls]
				assert(last_call.is_end)
				assert(last_call.value == 110)
				assert(last_call.time_elapsed == 0.1)
				assert(last_call.time_total == 0.1)

				for call_index = 1, #calls - 1 do
					local call = calls[call_index]
					assert(not call.is_end)
					assert(call.time_elapsed < 0.1)
					assert(call.time_total == 0.1)
					assert(call_index == 1 or call.time_elapsed >= calls[call_index - 1].time_elapsed)
				end
			end
		end)

		it("Tween with zero time ends on the first tick with the target value", function()
			local record = record_tween(tweener, go.EASING_LINEAR, 0, 50, 0)
			assert(#record.calls == 0)

			assert(test_wait.until_true(function() return #record.calls > 0 end))
			test_wait.frames(5)

			assert(#record.calls == 1)
			assert(record.calls[1].value == 50)
			assert(record.calls[1].is_end)
			assert(record.calls[1].time_elapsed == 0)
			assert(record.calls[1].time_total == 0)
			assert(not tweener.is_active(record.tween))
		end)

		it("Tween can be cancelled inside its callback", function()
			local calls = 0
			local cancel_result = nil
			local tween = nil
			tween = tweener.tween(go.EASING_LINEAR, 0, 1, 1, function()
				calls = calls + 1
				cancel_result = tweener.cancel(tween)
			end)

			assert(test_wait.until_true(function() return calls > 0 end))
			test_wait.seconds(0.05)

			assert(calls == 1)
			assert(cancel_result == true)
			assert(not tweener.is_active(tween))
			assert(tweener.cancel(tween) == false)
		end)

		it("Tween is not active in its final callback and cancel of a finished tween returns false", function()
			local end_calls = 0
			local cancel_result = nil
			local is_active_on_end = nil
			local tween = nil
			tween = tweener.tween(go.EASING_LINEAR, 0, 1, 0.05, function(value, is_end)
				if is_end then
					end_calls = end_calls + 1
					is_active_on_end = tweener.is_active(tween)
					cancel_result = tweener.cancel(tween)
				end
			end)

			assert(test_wait.until_true(function() return end_calls > 0 end))
			test_wait.frames(5)

			assert(end_calls == 1)
			assert(is_active_on_end == false)
			assert(cancel_result == false)
			assert(tweener.cancel(tween) == false)
			assert(tweener.cancel(nil) == false)
		end)

		it("Tween started in a callback updates from the next tick", function()
			local is_first_ended = false
			local second_calls = 0
			tweener.tween(go.EASING_LINEAR, 0, 1, 0.05, function(value, is_end)
				if is_end then
					is_first_ended = true
					tweener.tween(go.EASING_LINEAR, 0, 1, 0.05, function()
						second_calls = second_calls + 1
					end)
				end
			end)

			-- The test continues in the script update, after all timers of the frame where the first tween ended
			assert(test_wait.until_true(function() return is_first_ended end))
			assert(second_calls == 0)
			assert(test_wait.until_true(function() return second_calls > 0 end))
		end)

		it("Many tweens can finish and cancel each other on the same frame", function()
			local count = 50
			local tweens = {}
			local end_calls = {}
			local end_values = {}
			local is_cancelled = {}
			for index = 1, count do
				end_calls[index] = 0
				is_cancelled[index] = false
			end

			for index = 1, count do
				tweens[index] = tweener.tween(go.EASING_OUTSINE, 0, 1, 0.05, function(value, is_end)
					if is_end then
						end_values[index] = value
						end_calls[index] = end_calls[index] + 1
						local next_index = index % count + 1
						if tweener.cancel(tweens[next_index]) then
							is_cancelled[next_index] = true
						end
					end
				end)
			end

			assert(test_wait.until_true(function()
				for index = 1, count do
					if tweener.is_active(tweens[index]) then
						return false
					end
				end
				return true
			end))
			test_wait.frames(5)

			for index = 1, count do
				if is_cancelled[index] then
					assert(end_calls[index] == 0)
				else
					assert(end_calls[index] == 1)
					assert(end_values[index] == 1)
				end
			end
		end)

		it("Tweens with different update frequencies", function()
			local fast = record_tween(tweener, go.EASING_LINEAR, 0, 1, 0.5, 1 / 60)
			local slow = record_tween(tweener, go.EASING_LINEAR, 0, 1, 0.5, 0.1)

			assert(test_wait.until_true(function()
				return not tweener.is_active(fast.tween) and not tweener.is_active(slow.tween)
			end))

			local slow_calls = slow.calls
			assert(#slow_calls >= 3 and #slow_calls <= 7)
			assert(#fast.calls > #slow_calls)
			assert(slow_calls[#slow_calls].value == 1)
			assert(fast.calls[#fast.calls].value == 1)

			local slow_average_step = (slow_calls[#slow_calls - 1].time_elapsed - slow_calls[1].time_elapsed) / (#slow_calls - 2)
			assert(slow_average_step >= 0.08)
		end)

		it("Paused tween does not update and does not count the paused time", function()
			local record = record_tween(tweener, go.EASING_LINEAR, 0, 1, 0.1)
			tweener.set_pause(record.tween, true)

			test_wait.seconds(0.2)
			assert(#record.calls == 0)
			assert(tweener.is_active(record.tween))

			tweener.set_pause(record.tween, false)
			local resume_time = socket.gettime()
			assert(test_wait.until_true(function() return not tweener.is_active(record.tween) end))

			assert(socket.gettime() - resume_time >= 0.07)
			assert(record.calls[1].time_elapsed < 0.1)
			local last_call = record.calls[#record.calls]
			assert(last_call.is_end)
			assert(last_call.value == 1)
		end)

		it("Tween timer_id is the tween own timer handle", function()
			-- Other libraries use timer.trigger and timer.cancel with the tween timer_id
			local record = record_tween(tweener, go.EASING_LINEAR, 0, 100, 1)

			timer.trigger(record.tween.timer_id)
			assert(#record.calls == 1)
			assert(not record.calls[1].is_end)
			assert(record.calls[1].value < 100)

			timer.cancel(record.tween.timer_id)
			test_wait.seconds(0.05)
			assert(#record.calls == 1)
		end)

		it("Tween runs in the context of the .script or .gui_script that created it", function()
			msg.post("/owner#script", "start", { time = 0.1 })
			msg.post("/owner#gui", "start", { time = 0.1 })

			assert(test_wait.until_true(function() return tween_owner.script.is_end and tween_owner.gui.is_end end))
			assert(tween_owner.script.last_value == 100)
			assert(tween_owner.gui.last_value == 100)

			-- Delete the owner game object: its .script and .gui_script tweens stop
			local script_count = tween_owner.script.count
			local gui_count = tween_owner.gui.count
			msg.post("/owner#script", "start", { time = 10 })
			msg.post("/owner#gui", "start", { time = 10 })
			assert(test_wait.until_true(function()
				return tween_owner.script.count > script_count and tween_owner.gui.count > gui_count
			end))

			msg.post("/owner#script", "delete")
			test_wait.frames(5)
			script_count = tween_owner.script.count
			gui_count = tween_owner.gui.count

			test_wait.seconds(0.1)
			assert(tween_owner.script.count == script_count)
			assert(tween_owner.gui.count == gui_count)
			assert(not tween_owner.script.is_end)
			assert(not tween_owner.gui.is_end)
		end)
	end)
end
