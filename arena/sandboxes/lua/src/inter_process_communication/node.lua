local json = require'../../lib/json'

local function sleep(sec) os.execute('sleep ' .. sec) end

local function _read()
  -- print('{"name":"starting lua read"}');
  repeat
    data = io.stdin:read()
    sleep(.01)
  until data
  return json.decode(data)
end

return {
  read = function() return _read() end,
  write = function(data)
      -- print('{"name": "starting lua write"}');
    io.stdout:write(json.encode(data))
    io.stdout:flush()
  end
}
