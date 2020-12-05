-- Enable rednet
peripheral.find("modem", rednet.open)

-- Request update
rednet.broadcast("get_turtle_link")
local sender_id, message, protocol = rednet.receive()

-- Update API
if message then
    local download_contents = http.get(umessagerl)
    local file = fs.open("turtle_run.lua","message")
    file.write(download_contents.readAll())
    file.close()
end

-- Run turtle script
shell.run("turtle_run")
