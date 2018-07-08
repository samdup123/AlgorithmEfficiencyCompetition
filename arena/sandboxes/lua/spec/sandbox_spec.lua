local mach = require'mach'
local Sandbox = require'sandbox'

describe('Sandbox', function()
  local publish = mach.mock_function('publish')
  local problem_object = mach.mock_table({func = function() end, other_func= function() end}, 'problem_object');

  it('should handle api call', function()
    local user_code = 'api.func()'
    local sandbox =  Sandbox(user_code, problem_object, publish)

    local api_call = {name = 'func'}
    publish:should_be_called_with(mach.match(api_call))
    :and_also(problem_object.func:should_be_called())
      :when(function() sandbox.run() end)
  end)

  it('should handle call with arguments', function()
    local user_code = 'api.func(1, 7)'
    local sandbox = Sandbox(user_code, problem_object, publish)

    local api_call = {name = 'func', params = {1, 7}}
    publish:should_be_called_with(mach.match(api_call))
    :and_also(problem_object.func:should_be_called_with(1, 7))
      :when(function() sandbox.run() end)
  end)

  it('should handle call with return value', function()
    local user_code = 'local value = api.func(6); api.other_func(value)'
    local sandbox = Sandbox(user_code, problem_object, publish)

    local first_api_call = {name = 'func', params = {6}}
    local second_api_call = {name = 'other_func', params = {'a return value'}}
    publish:should_be_called_with(mach.match(first_api_call))
    :and_also(problem_object.func:should_be_called_with(6):and_will_return('a return value'))
    :and_also(publish:should_be_called_with(mach.match(second_api_call)))
    :and_also(problem_object.other_func:should_be_called_with(mach.match('a return value')))
      :when(function() sandbox.run() end)
  end)
end)
