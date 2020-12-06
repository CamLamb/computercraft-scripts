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

function GetTurtleLink()
    return GetDownloadLink("turtle")
end

function GetDispatcherLink()
    return GetDownloadLink("dispatcher")
end

function TurtleWaiting()
    print("Turtle waiting for command")
    return read()
end

-- Define commands
local commands = {
    get_turtle_link=GetTurtleLink,
    get_dispatcher_link=GetDispatcherLink,
    turtle_waiting=TurtleWaiting,
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

    -- Split message
    local message_sections = {}
    for word in message:gmatch("%S+") do table.insert(message_sections, word) end
    local command = commands[message_sections[1]]
    table.remove(message_sections, 1)
    -- Run command
    if command ~= nil then
        rednet.send(sender_id, command(message_sections))
    end
end
