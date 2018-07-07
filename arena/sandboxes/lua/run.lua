local user_code_file = arg[1]
local api_def_file = arg[2]

package.path = package.path .. ';/home/sam/git/api-thingy/arena/sandboxes/lua/?.lua'

local json = require'lib.json'
local communicator = require'src.inter_process_communication.node'
local user_code = io.open(user_code_file):read('*a')
local api = json.decode(io.open(api_def_file):read('*a'))

local sandbox = require'src.sandbox.sandbox'(user_code, api, communicator)

sandbox.run()
