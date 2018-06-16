function blah(problemObject, problemCompletedChecker, problemApi)
  local callRecords = ""
  function setUpCallRecordLogging(t)
    local proxy = {}
    local problemApiMt = {}
    problemApiMt.__index = function(_, k)
      callRecords = callRecords .. k  .. '\n'
      return function(...)
        problemObject[k](...)
        if problemCompletedChecker(problemObject) then callRecords = callRecords .. 'done' .. '\n' end
        end
      end
    return setmetatable(proxy,problemApiMt)
  end

  problemApi = setUpCallRecordLogging(problemApi)

return function(userInput)
    load('api = ...;' .. userInput)(problemApi)
    return callRecords
  end
end

return blah
