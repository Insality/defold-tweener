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
	end)
end
