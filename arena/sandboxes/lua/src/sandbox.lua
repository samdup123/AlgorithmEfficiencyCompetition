function call_record_logging_table(problem_object, publish)
  local proxy = {}
  local problemApiMt = {}
  problemApiMt.__index = function(_, call_name)
    return function(...)
      local call = {name = call_name}
      local args = {...}
      if #args ~= 0 then call.params = args end
      publish(call)

      return problem_object[call_name](...)
    end
  end
  return setmetatable(proxy,problemApiMt)
end

return function(user_code, problem_object, publish)
  local api_object = call_record_logging_table(problem_object, publish)
  local run_user_code_with = load('api = ...;' .. user_code)

  return { run = function() run_user_code_with(api_object) end }
end
