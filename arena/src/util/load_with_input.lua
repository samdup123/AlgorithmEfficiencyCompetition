return function(thing)
  return {
    as = function(name)
      return function(string)
        print(load('function a(thing) local ' .. name .. ' = thing; ' .. string .. '; end'))
        return load('function input_into_load(thing) local ' .. name .. ' = thing; ' .. string .. '; end')(thing)
      end
    end
  }
end
