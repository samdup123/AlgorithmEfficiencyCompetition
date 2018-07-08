local user_code = 'api.swap(1,5);api.swap(2,4)'
local publish = require'src.reporter'
local array = {5, 4, 3, 2, 1}
local problem_object =
  {
    swap =
      function(a, b)
        a = a
        b = b
        local temp = array[a]
        array[a] = array[b]
        array[b] = temp
      end
  }

local sandbox = require'src.sandbox'(user_code, problem_object, publish)

publish({initial =  array})
sandbox.run()
publish({final = array})
