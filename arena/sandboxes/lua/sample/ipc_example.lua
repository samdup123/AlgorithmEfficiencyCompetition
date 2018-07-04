local node = require'../src/inter_process_communication/node'

node.write(node.read())

node.write({its = 'over'})

-- run `lua ipc_example.lua
-- enter some json text like {"name": "sam"}
-- it should spit it back out to you
-- then it should end
