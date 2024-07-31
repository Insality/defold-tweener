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
		end)
	end)
end
