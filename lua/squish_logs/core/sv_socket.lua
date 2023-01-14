require("gwsockets")


local firstConnect = false
local freezer = {}
function SquishLogs.Socket.StartConnection()
	print("[Squish Logs]", "Starting websocket connection")

	if SquishLogs.Socket.Connection then
		SquishLogs.Socket.Connection:closeNow()
	end

	SquishLogs.Socket.Connection = GWSockets.createWebSocket(SquishLogs.Server.socket.ip_address, false)

	function SquishLogs.Socket.Connection:onMessage(txt)
		// They're reconnecting on an existing session
		if (firstConnect) then return end
		firstConnect = true // This is to prevent the archive from triggering again if connection was lost
		
		// Receive a response informing us the auth was successful
		local response = util.JSONToTable(txt)

		if (!response) then return end
		if (!response.type or !(response.type == 'auth-response')) then return end
		if (!response.success) then return end

		SquishLogs.Core.IsAuthed = true

		SquishLogs.Core.Archive()
		SquishLogs.Core.SimpleLog("Server started")

		for k, v in ipairs(freezer) do
			PrintTable(v)
			SquishLogs.Socket.Send(v)
		end
	end
	
	function SquishLogs.Socket.Connection:onError(txt)
		print("[Squish Logs]", "Error: ", txt)
	end
	
	function SquishLogs.Socket.Connection:onConnected()
		print("[Squish Logs]", "Connection made, attempting to auth as server")
		SquishLogs.Socket.Send({
			type = "auth",
			community = SquishLogs.Info.Community,
			token = SquishLogs.Info.Token
		}, true)
	end
	function SquishLogs.Socket.Connection:onDisconnected()
		print("[Squish Logs]", "WebSocket disconnected")
		SquishLogs.Socket.StartConnection()
	end
	
	function SquishLogs.Socket.Send(data, bypassFreezer)
		// In some cases, the server may not be authed when logs are coming in.
		// To prevent losing data, we add them to the freezer and send them off
		// once auth is complete.
		if (!SquishLogs.Core.IsAuthed and !bypassFreezer) then
			table.insert(freezer, data)

			return
		end

		SquishLogs.Socket.Connection:write(util.TableToJSON(data))

		hook.Run('SquishLogs:Send', data)
	end

	print("[Squish Logs]", "Attempting to connect to", SquishLogs.Server.socket.name)
	SquishLogs.Socket.Connection:open()
end