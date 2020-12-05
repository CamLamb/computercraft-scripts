-- Enable rednet
peripheral.find("modem", rednet.open)

-- Request update
rednet.broadcast("get_dispatcher_link")
local sender_id, message, protocol = rednet.receive()

-- Update API
if message then
    local download_contents = http.get(message)
    local file = fs.open("dispatcher_run.lua","message")
    file.write(download_contents.readAll())
    file.close()
end

-- Run dispatcher script
shell.run("dispatcher_run")
