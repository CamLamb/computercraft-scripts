-- Enable rednet
peripheral.find("modem", rednet.open)

-- Request update
local url = ""

-- Update API
if url then
    local download_contents = http.get(url)
    local file = fs.open("turtle_run.lua","w")
    file.write(download_contents.readAll())
    file.close()
end

-- Run turtle script
shell.run("turtle_run")
