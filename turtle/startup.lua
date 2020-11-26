-- Get fuel
turtle.suckDown()
if turtle.getFuelLevel() < 1000 then
    turtle.refuel()
end

-- Leave base
shell.run("leave_base")

-- Get instruction
rednet.open("right")

-- Perform instruction

-- Test task
-- shell.run("navigate_to", -1148, 501, 56)
-- shell.run("tunnel", 10)

-- Go to death
shell.run("die")
