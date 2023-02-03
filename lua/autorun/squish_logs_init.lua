SquishLogs = {}
SquishLogs.Info = {}
SquishLogs.Socket = {}
SquishLogs.Core = {}

SquishLogs.Info.Version = "1.0.6"
SquishLogs.Info.Domain = "{{ community_domain }}"

print("Loading Squish Logs")

local path = "squish_logs/"
if (SERVER) then
	local files, folders = file.Find(path .. "*", "LUA")

	for _, folder in ipairs(folders) do
		print("Loading folder:", folder)
	    for b, File in ipairs(file.Find(path .. folder .. "/sh_*.lua", "LUA")) do
	    	print("Loading file:", File)
	        AddCSLuaFile(path .. folder .. "/" .. File)
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in ipairs(file.Find(path .. folder .. "/sv_*.lua", "LUA")) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in ipairs(file.Find(path .. folder .. "/cl_*.lua", "LUA")) do
	    	print("Loading file:", File)
	        AddCSLuaFile(path .. folder .. "/" .. File)
	    end
	end
else
	local files, folders = file.Find(path .. "*", "LUA")

	for _, folder in ipairs(folders) do
		print("Loading folder:", folder)
	    for b, File in ipairs(file.Find(path .. folder .. "/sh_*.lua", "LUA")) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end

	    for b, File in ipairs(file.Find(path .. folder .. "/cl_*.lua", "LUA")) do
	    	print("Loading file:", File)
	        include(path .. folder .. "/" .. File)
	    end
	end
end

print("Loaded Squish Logs")