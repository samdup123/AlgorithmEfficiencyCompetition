local Sandbox = require("sandbox")

describe("SandBox", function()
  it('should evaluate input given that the problemCompletedChecker just returns true', function()
    local problemObject = { func = function() end }
    local problemCompletedChecker = function() return true end
    local problemApi = { func = function() end }

    local sandbox = Sandbox(problemObject, problemCompletedChecker, problemApi)

    assert.are.same("func\ndone\n", sandbox("api.func()"))
  end)

  it('should evaluate input given that the problemCompletedChecker returns true after three calls', function()
    local problemObject = { func = function() end }
    local i = 0
    local problemCompletedChecker = function()
      i = i + 1
      if i == 2 then return true end
    end
    local problemApi = { func = function() end }

    local sandbox = Sandbox(problemObject, problemCompletedChecker, problemApi)

    assert.are.same("func\nfunc\ndone\n", sandbox("api.func();api.func()"))
  end)

  it('should not be able to use the print function', function()
    local problemObject = { func = function() end }
    local problemCompletedChecker = function() return true end
    local problemApi = { func = function() end }

    local sandbox = Sandbox(problemObject, problemCompletedChecker, problemApi)

    assert.are.same("Use of print function is not allowed", sandbox("print(4)"))
  end)
end)
