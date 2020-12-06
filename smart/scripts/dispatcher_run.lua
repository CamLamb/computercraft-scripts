-- Define functions 

function DispatchTurtle()
    -- Turn 180
    turtle.turnLeft()
    turtle.turnLeft()
    -- Get Turtle from chest
    turtle.suck()
    -- Turn 180
    turtle.turnLeft()
    turtle.turnLeft()
    -- Place Turtle (When the space in front is empty)
    while true do
        local success, data = turtle.inspect()
        if not success then
            turtle.select(1)
            turtle.place()
            local placed_turtle = peripheral.wrap("front")
            placed_turtle.turnOn()
            break
        end
    end
end

function KillTurtle()
    -- Dig up the turtle from above
    local success, data = turtle.inspectUp()
    if success and string.match(data.name, "turtle") then
        turtle.digUp()
    end
    -- Turn 180
    turtle.turnLeft()
    turtle.turnLeft()
    -- Place Turtle in chest
    turtle.drop()
    -- Turn 180
    turtle.turnLeft()
    turtle.turnLeft()
end

-- Define commands
local commands = {
    dispatch_turtle=DispatchTurtle,
    kill_turtle=KillTurtle,
}

-- Start listening to rednet for commands
while true do
    print("Listening for commands...")
    local sender_id, message, protocol = rednet.receive()

    if commands[message] ~= nil then
        rednet.send(sender_id, commands[message]())
    end
end
