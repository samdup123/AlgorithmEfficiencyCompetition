local json = require'../../lib/json'

local function sleep(sec) os.execute('sleep ' .. sec) end

local function _read()
  repeat
    data = io.stdin:read()
    sleep(.01)
  until data

  return json.decode(data)
end

return {
  read = function() return _read() end,
  write = function(data)
    io.stdout:write(json.encode(data))
    io.stdout:flush()
  end
}
