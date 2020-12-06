-- Enable rednet
peripheral.find("modem", rednet.open)

local monitor = peripheral.find("monitor")
local oldTerm = term.redirect(monitor)

while true do
    local sender_id, message, protocol = rednet.receive()
    if protocol ~= nil then
        print(sender_id .. "(" .. protocol .. "): " .. message)
    else
        print(sender_id .. ": " .. message)
    end
end

term.redirect(oldTerm)
