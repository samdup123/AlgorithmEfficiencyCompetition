local function sleep(sec) os.execute('sleep ' .. sec) end

local function check_if_available(name)
  local possible_file = io.open(name, 'r')
  if 'file' == io.type(possible_file) then return possible_file end
end

local function get_file(name)
  local next_file_exists
  repeat
    next_file_exists = check_if_available(name)
    sleep(.01)
  until next_file_exists
end

return function (name)
  local limit = 10
  local function prev(n) return ((n + (limit - 1)) % limit) end

  local count = 0
  while true do
    get_file(name .. count)
    os.execute('rm ' .. name .. prev(count))
  end
end
