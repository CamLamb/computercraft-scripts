local x, y, z = ...


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

print("Facing North")

-- Route to new location
local end_pos = vector.new(x, y, z)
local position_difference = end_pos - new_pos
print("new_pos")
print(new_pos)
print("end_pos")
print(end_pos)
print("position_difference")
print(position_difference)

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
print(x_move)
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

print("Navigated along the East/West line")

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
print(y_move)
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

print("Navigated along the North/South line")

-- Navigate North/South
local z_move = position_difference.z
print(z_move)
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

print("Navigated along the Up/Down line")