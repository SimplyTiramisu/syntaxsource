return function()
	local createSpy = require(script.Parent.Parent.createSpy)

	describe("createSpy", function()
		it("should create spies", function()
			local spy = createSpy(function() end)

			expect(spy).to.be.ok()
		end)

		it("should throw if spies are indexed by an invalid key", function()
			local spy = createSpy(function() end)

			expect(function()
				return spy.test
			end).to.throw()
		end)
	end)

	describe("value", function()
		it("should increment callCount when called", function()
			local spy = createSpy(function() end)
			spy.value()

			expect(spy.callCount).to.equal(1)
		end)

		it("should store all values passed", function()
			local spy = createSpy(function() end)
			spy.value(1, true, "3")

			expect(spy.valuesLength).to.equal(3)
			expect(spy.values[1]).to.equal(1)
			expect(spy.values[2]).to.equal(true)
			expect(spy.values[3]).to.equal("3")
		end)

		it("should return the value of the inner function", function()
			local spy = createSpy(function()
				return true
			end)

			expect(spy.value()).to.equal(true)
		end)
	end)

	describe("assertCalledWith", function()
		it("should throw if the number of values differs", function()
			local spy = createSpy(function() end)
			spy.value(1, 2)

			expect(function()
				spy:assertCalledWith(1)
			end).to.throw()
		end)

		it("should throw if any value differs", function()
			local spy = createSpy(function() end)
			spy.value(1, 2)

			expect(function()
				spy:assertCalledWith(1, 3)
			end).to.throw()

			expect(function()
				spy:assertCalledWith(2, 3)
			end).to.throw()
		end)
	end)

	describe("captureValues", function()
		it("should throw if the number of values differs", function()
			local spy = createSpy(function() end)
			spy.value(1, 2)

			expect(function()
				spy:captureValues("a")
			end).to.throw()
		end)

		it("should capture all values in a table", function()
			local spy = createSpy(function() end)
			spy.value(1, 2)

			local captured = spy:captureValues("a", "b")
			expect(captured.a).to.equal(1)
			expect(captured.b).to.equal(2)
		end)
	end)

	describe("calls", function()
		it("should keep all the arguments given to each call", function()
			local spy = createSpy()
			local firstCall = {}
			spy.value(firstCall)
			local secondCall = {}
			spy.value(secondCall)

			expect(spy.calls[1][1]).to.equal(firstCall)
			expect(spy.calls[2][1]).to.equal(secondCall)
		end)
	end)

	describe("mockClear", function()
		it("clears the spy state", function()
			local spy = createSpy()
			spy.value(1)
			expect(spy.callCount).to.equal(1)

			spy:mockClear()

			expect(spy.callCount).to.equal(0)
			expect(#spy.calls).to.equal(0)
			expect(#spy.values).to.equal(0)
			expect(spy.valuesLength).to.equal(0)
		end)
	end)

	describe("call", function()
		it("should increment callCount when called", function()
			local spy = createSpy(function() end)
			spy()

			expect(spy.callCount).to.equal(1)
		end)

		it("should store all values passed", function()
			local spy = createSpy(function() end)
			spy(1, true, "3")

			expect(spy.valuesLength).to.equal(3)
			expect(spy.values[1]).to.equal(1)
			expect(spy.values[2]).to.equal(true)
			expect(spy.values[3]).to.equal("3")
		end)

		it("should return the value of the inner function", function()
			local spy = createSpy(function()
				return true
			end)

			expect(spy()).to.equal(true)
		end)
	end)
end
