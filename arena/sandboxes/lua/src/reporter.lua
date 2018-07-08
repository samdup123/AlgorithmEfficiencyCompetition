local json = require'../lib/json'
local file = io.open('file', 'w')
return function(data)
  file:write(json.encode(data) .. '\n')
end
