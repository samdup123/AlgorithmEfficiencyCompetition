return function (_in, out)
  local limit = 10
  local read_count = 0
  local write_count = 0

  local function sleep(sec) os.execute('sleep ' .. sec) end

  local function get_file_if_available(name)
    local possible_file = io.open(name, 'r')
    if 'file' == io.type(possible_file) then return possible_file end
  end

  local function _read(from)
    local file
    repeat
      file = get_file_if_available(from)
      sleep(.01)
    until file

    return file:read()
  end

  local function _write(to, data)
    local file = io.open(to, 'w')
    file:write(data)
    file:close()
  end

    return {
      read = function()
        read_count = (read_count + 1) % limit
        return _read(_in .. read_count)
      end,
      write = function(data)
        write_count = (write_count + 1) % limit
        _write(out .. write_count, data)
      end
    }
end
