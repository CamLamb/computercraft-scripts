-- Enable rednet
peripheral.find("modem", rednet.open)

-- Define variables
local turtle_download = ""

-- Start listening to rednet for commands
