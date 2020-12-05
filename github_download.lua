-- Github download
-- 
-- Usage:
-- github_download path/to/file/on/github local_filename
-- 
-- Example:
-- File to download = https://raw.githubusercontent.com/jafacakes2011/computercraft-scripts/main/smart/scripts/turtle_run.lua
-- Local script name = turtle_run
-- github_download smart/scripts/turtle_run.lua turtle_run

local args = {...}

local github_raw_url = "https://raw.githubusercontent.com"
local github_path = "jafacakes2011/computercraft-scripts"
local github_branch = "main"

local url = github_raw_url .. "/" .. github_path .. "/" .. github_branch .. "/" .. args[1]

local download_contents = http.get(url)
local file = fs.open(args[2] .. ".lua","w")
file.write(download_contents.readAll())
file.close()