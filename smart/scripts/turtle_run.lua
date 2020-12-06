-- Define functions

function NavigateTo(x, y, z)
    function dig(direction)
        local current_pos = vector.new(gps.locate())
        if current_pos.x < -1060 then
            if direction == "forward" then
                turtle.dig()
            elseif direction == "up" then
                turtle.digUp()
            elseif direction == "down" then
                turtle.digDown()
            end
        end
    end

    -- Rotate to point North
    local current_pos = vector.new(gps.locate())
    dig("forward")
    turtle.forward()
    local new_pos = vector.new(gps.locate())
    local position_difference = new_pos - current_pos

    if position_difference.x ~= 0 then
        if position_difference.x > 0 then
            turtle.turnLeft()
        elseif position_difference.x < 0 then
            turtle.turnRight()
        end
    end
    if position_difference.y ~= 0 then
        if position_difference.y > 0 then
            turtle.turnLeft()
            turtle.turnLeft()
        elseif position_difference.y < 0 then
        end
    end

    -- Route to new location
    local end_pos = vector.new(x, y, z)
    local position_difference = end_pos - new_pos

    -- Note how many left turns to face north
    local turn_left = 0

    if position_difference.x > 0 then
        -- Face East
        turtle.turnRight()
        turn_left = 1
    elseif position_difference.x < 0 then
        -- Face West
        turtle.turnLeft()
        turn_left = 3
    end

    -- Navigate East/West
    local x_move = position_difference.x
    while x_move ~= 0 do
        if turtle.detect() then
            dig("forward")
        end

        turtle.forward()

        if x_move < 0 then
            x_move = x_move + 1
        else
            x_move = x_move - 1
        end
    end

    while turn_left ~= 0 do
        turtle.turnLeft()
        turn_left = turn_left - 1
    end

    -- Note how many left turns to face north
    local turn_left = 0

    if position_difference.y ~= 0 then
        if position_difference.y > 0 then
            -- Facing South
            turtle.turnLeft()
            turtle.turnLeft()
            turn_left = 2
        elseif position_difference.y < 0 then
            -- Facing North
        end
    end


    -- Navigate North/South
    local y_move = position_difference.y
    while y_move ~= 0 do
        if turtle.detect() then
            dig("forward")
        end

        turtle.forward()

        if y_move < 0 then
            y_move = y_move + 1
        else
            y_move = y_move - 1
        end
    end

    while turn_left ~= 0 do
        turtle.turnLeft()
        turn_left = turn_left - 1
    end

    -- Navigate North/South
    local z_move = position_difference.z
    while z_move ~= 0 do
        if z_move < 0 then
            if turtle.detectDown() then
                dig("down")
            end
            turtle.down()
            z_move = z_move + 1
        else
            if turtle.detectUp() then
                dig("up")
            end
            turtle.up()
            z_move = z_move - 1
        end
    end
end

function LeaveBase()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
    turtle.down()
end

function Die()
    -- Go to the Turtle return layer
    local current_pos = vector.new(gps.locate())
    NavigateTo(current_pos.x, current_pos.y, 61)

    -- Navigate to base entrance
    NavigateTo(-1060, 515, 61)
    turtle.turnRight()

    -- Enter base
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.up()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()

    -- Empty inventory
    turtle.drop(1)
    turtle.drop(2)
    turtle.drop(3)
    turtle.drop(4)
    turtle.drop(5)
    turtle.drop(6)
    turtle.drop(7)
    turtle.drop(8)
    turtle.drop(9)
    turtle.drop(10)
    turtle.drop(11)
    turtle.drop(12)
    turtle.drop(13)
    turtle.drop(14)
    turtle.drop(15)
    turtle.drop(16)

    -- Request death
    rednet.broadcast("kill_turtle")
end

function NavigateToCommand(table)
    return NavigateTo(table[1], table[2], table[3])
end

-- Define commands
local commands = {
    navigate_to=NavigateToCommand,
}

-- Startup script

-- Get fuel
if turtle.getFuelLevel() < 1000 then
    turtle.suckDown()
    turtle.refuel()
end

-- Leave base
LeaveBase()

-- Wait for command
rednet.broadcast("turtle_waiting")
local sender_id, message, protocol = rednet.receive()

-- Split message
local message_sections = {}
for word in message:gmatch("%S+") do table.insert(message_sections, word) end
local command = commands[message_sections[1]]
table.remove(message_sections, 1)

-- Run command
if command ~= nil then
    command(message_sections)
end

-- Go to death
Die()
