function call_record_logging_table(api, communicator, json)
  local proxy = {}
  local problemApiMt = {}
  problemApiMt.__index = function(_, call_name)
    return function(...)
      local call = {name = call_name}
      local args = {...}
      if #args ~= 0 then call.params = args end

      if api[call_name].returns then call.returns = true end
      communicator.write(json.encode(call))
      if call.returns then return communicator.read() end
    end
  end
  return setmetatable(proxy,problemApiMt)
end

return function(user_code, api_json, communicator, json)
  local api = json.decode(api_json)
  local api_object = call_record_logging_table(api, communicator, json)
  local run_user_code_with = load('api = ...;' .. user_code)

  return { run = function() run_user_code_with(api_object) end }
end
