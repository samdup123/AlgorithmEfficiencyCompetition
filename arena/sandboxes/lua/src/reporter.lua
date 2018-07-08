local json = require'../lib/json'

return function(data) 
  io.stdout:write(json.encode(data))
end
