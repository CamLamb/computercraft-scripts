
local current_pos = vector.new(gps.locate())

-- Navigate to base entrance
shell.run("navigate_to", current_pos.x, current_pos.y, 61)
shell.run("navigate_to", -1060, 515, 61)
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