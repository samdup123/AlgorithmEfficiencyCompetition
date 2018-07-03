local mach = require'mach'
local Sandbox = require'sandbox/sandbox'

describe('Sandbox', function()
  local communication = mach.mock_table({read = function() end, write = function() end}, 'communication')
  local json = mach.mock_table({encode = function() end, decode = function() end}, 'json')

  local should_initialize_sandbox_with = function(api, user_code)
    local sandbox
    json.decode:should_be_called_with('an api string'):and_will_return(api)
      :when(function() sandbox = Sandbox(user_code, 'an api string', communication, json) end)
    return sandbox
  end

  local should_send_encoded_json_to_communicator_for = function(api_call)
    return json.encode:should_be_called_with(mach.match(api_call)):and_will_return('a json string'):
    and_also(communication.write:should_be_called_with('a json string'))
  end

  local communicator_should_be_read_and_it_will_return = function(return_value)
    return communication.read:should_be_called():and_will_return(return_value)
  end

  it('should write message when user code uses a function from the api', function()
    local api = {func = {}}
    local user_code = 'api.func()'
    local sandbox =  should_initialize_sandbox_with(api, user_code)

    local api_call = {name = 'func'}
    should_send_encoded_json_to_communicator_for(api_call)
      :when(function() sandbox.run() end)
  end)

  it('should write message that contains arguments', function()
    local api = {func = {}}
    local user_code = 'api.func(1, 7)'
    local sandbox = should_initialize_sandbox_with(api, user_code)

    local api_call = {name = 'func', params = {1, 7}}
    should_send_encoded_json_to_communicator_for(api_call)
      :when(function() sandbox.run() end)
  end)

  it('should write message that asks for a return value and then read the return value', function()
    local api = {func = {returns = true}, other_func = {}}
    local user_code = 'local value = api.func(1, 7); api.other_func(value)'
    local sandbox = should_initialize_sandbox_with(api, user_code)

    local first_api_call = {name = 'func', params = {1, 7}, returns = true}
    local second_api_call = {name = 'other_func', params = {'a return value'}}
    should_send_encoded_json_to_communicator_for(first_api_call)
    :and_also(communicator_should_be_read_and_it_will_return('a return value'))
    :and_also(should_send_encoded_json_to_communicator_for(second_api_call))
      :when(function() sandbox.run() end)
  end)
end)
