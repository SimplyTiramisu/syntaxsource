return function()
	local Config = require(script.Parent.Config)

	describe("General", function()
		describe("HttpDelay", function()
			it("should be disabled", function()
				expect(Config.General.HttpDelay).to.equal(false)
			end)
		end)

		describe("PerformanceTestingMode", function()
			it("should be disabled", function()
				expect(Config.General.PerformanceTestingMode).to.equal(Enum.VirtualInputMode.None)
			end)
		end)
	end)

	describe("LuaChat", function()
		describe("Debug", function()
			it("should be disabled", function()
				expect(Config.LuaChat.Debug).to.equal(false)
			end)
		end)
	end)
end