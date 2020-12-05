-- Enable rednet
peripheral.find("modem", rednet.open)

-- Define variables
local github_raw_url = "https://raw.githubusercontent.com"
local github_path = "jafacakes2011/computercraft-scripts"
local github_branch = "main"

local downloads = {
    turtle="smart/scripts/turtle_run.lua",
    dispatcher="smart/scripts/dispatcher_run.lua",
}

function GetDownloadLink(type)
    return github_raw_url .. "/" .. github_path .. "/" .. github_branch .. "/" .. downloads[type]
end

-- Define commands
local commands = {
    get_turtle_link=GetDownloadLink("turtle"),
    get_dispatcher_link=GetDownloadLink("dispatcher"),
}

-- Start listening to rednet for commands
while true do
    print("Listening for requests...")
    local sender_id, message, protocol = rednet.receive()
    -- Act on response
    print("Received message from: " .. sender_id)
    if protocol then
        print("Using protocol: " .. protocol)
    end
    print("Message: " .. message)

    if commands[message] ~= nil then
        rednet.send(sender_id, commands[message])
    end
end
