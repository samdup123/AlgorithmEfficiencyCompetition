local problem_object_file = arg[1]
local problem_instance_file = arg[2]
local problem_object = loadfile(arg[1])(loadfile(arg[2])())

local call_log = io.open('log', 'w')

while true do
  local input = io.stdin:read()
  output = load('problem_object.' .. input)()
  io.stdout:write(output)
  call_log:write(input)
end
