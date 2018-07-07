local function _write() io.stdout:write('other thing') end
return {
  write = function() _write() end
}
