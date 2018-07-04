function call_record_logging_table(api, communicator)
  local proxy = {}
  local problemApiMt = {}
  problemApiMt.__index = function(_, call_name)
    return function(...)
      local call = {name = call_name}
      local args = {...}
      if #args ~= 0 then call.params = args end

      if api[call_name].returns then call.returns = true end
      communicator.write(call)
      if call.returns then return communicator.read() end
    end
  end
  return setmetatable(proxy,problemApiMt)
end

return function(user_code, api, communicator)
  local api_object = call_record_logging_table(api, communicator)
  local run_user_code_with = load('api = ...;' .. user_code)

  return { run = function() run_user_code_with(api_object) end }
end
