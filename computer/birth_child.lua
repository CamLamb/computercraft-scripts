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