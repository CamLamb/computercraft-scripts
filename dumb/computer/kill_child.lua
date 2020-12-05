-- Check block behind for turtle
local success, data = turtle.inspectUp()
if success and string.match(data.name, "turtle") then
    turtle.digUp()
end