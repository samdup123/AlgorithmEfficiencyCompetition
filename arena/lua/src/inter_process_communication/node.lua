local function sleep(sec) os.execute('sleep ' .. sec) end

local function _read()
  repeat
    data = io.stdin:read()
    sleep(.01)
  until data

  return data
end

return {
  read = function() return _read() end,
  write = function(data) io.stdout:write(data) end
}
