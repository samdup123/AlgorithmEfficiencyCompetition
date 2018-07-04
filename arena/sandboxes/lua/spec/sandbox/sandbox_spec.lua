local mach = require'mach'
local Sandbox = require'sandbox/sandbox'

describe('Sandbox', function()
  local communicator = mach.mock_table({read = function() end, write = function() end}, 'communicator')

  it('should write message when user code uses a function from the api', function()
    local api = {func = {}}
    local user_code = 'api.func()'
    local sandbox =  Sandbox(user_code, api, communicator)

    local api_call = {name = 'func'}
    communicator.write:should_be_called_with(mach.match(api_call))
      :when(function() sandbox.run() end)
  end)

  it('should write message that contains arguments', function()
    local api = {func = {}}
    local user_code = 'api.func(1, 7)'
    local sandbox = Sandbox(user_code, api, communicator)

    local api_call = {name = 'func', params = {1, 7}}
    communicator.write:should_be_called_with(mach.match(api_call))
      :when(function() sandbox.run() end)
  end)
  
  it('should write message that asks for a return value and then read the return value', function()
    local api = {func = {returns = true}, other_func = {}}
    local user_code = 'local value = api.func(1, 7); api.other_func(value)'
    local sandbox = Sandbox(user_code, api, communicator)

    local first_api_call = {name = 'func', params = {1, 7}, returns = true}
    local second_api_call = {name = 'other_func', params = {'a return value'}}
    communicator.write:should_be_called_with(mach.match(first_api_call))
    :and_also(communicator.read:should_be_called():and_will_return('a return value'))
    :and_also(communicator.write:should_be_called_with(mach.match(second_api_call)))
      :when(function() sandbox.run() end)
  end)
end)
