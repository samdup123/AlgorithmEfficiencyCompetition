local node = require'src/inter_process_communication/node'

local counter = 0

repeat node.write(node.read() .. '\n'); counter = counter + 1; until counter == 2

node.write('\n~its over~\n')

-- run `lua ipc_example.lua
-- enter some text
-- it should spit it back out to you
-- do this again
-- then it should end
