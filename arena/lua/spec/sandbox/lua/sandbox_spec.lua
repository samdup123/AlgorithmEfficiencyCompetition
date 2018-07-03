local mach = require'mach'
local Sandbox = require'sandbox/lua/sandbox'

describe('Sandbox', function()
  local communication = mach.mock_table({read = function() end, write = function() end}, 'communication')
  local json = mach.mock_table({encode = function() end, decode = function() end}, 'json')

  it('should write message when user code uses a function from the api', function()
    local user_code = 'api.func()'
    local sandbox
    json.decode:should_be_called_with('an api string'):and_will_return({func = {}})
      :when(function() sandbox = Sandbox(user_code, 'an api string', communication, json) end)

    json.encode:should_be_called_with(mach.match({name = 'func'})):and_will_return('a json string'):
    and_also(communication.write:should_be_called_with('a json string'))
      :when(function() sandbox.run() end)
  end)

  it('should write message that contains arguments', function()
    local user_code = 'api.func(1, 7)'
    local sandbox
    json.decode:should_be_called_with('an api string'):and_will_return({func = {}})
      :when(function() sandbox = Sandbox(user_code, 'an api string', communication, json) end)

    json.encode:should_be_called_with(mach.match({name = 'func', params = {1, 7} })):and_will_return('a json string'):
    and_also(communication.write:should_be_called_with('a json string'))
      :when(function() sandbox.run() end)
  end)

  it('should write message that asks for a return value and then read the return value', function()
    local user_code = 'local value = api.func(1, 7); api.other_func(value)'
    local sandbox
    json.decode:should_be_called_with('an api string'):and_will_return({func = {returns = true}, other_func = {}})
      :when(function() sandbox = Sandbox(user_code, 'an api string', communication, json) end)

    json.encode:should_be_called_with(mach.match({name = 'func', params = {1, 7}, returns = true})):and_will_return('a json string')
    :and_also(communication.write:should_be_called_with('a json string'))
    :and_also(communication.read:should_be_called():and_will_return('a return value'))
    :and_also(json.encode:should_be_called_with(mach.match({name = 'other_func', params = {'a return value'}})):and_will_return('a json string'))
    :and_also(communication.write:should_be_called_with('a json string'))
      :when(function() sandbox.run() end)
  end)
end)
