require("gwsockets")


local firstConnect = false
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

		SquishLogs.Core.Archive()
		SquishLogs.Core.SimpleLog("Server started")
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
		})
	end
	function SquishLogs.Socket.Connection:onDisconnected()
		print("[Squish Logs]", "WebSocket disconnected")
		SquishLogs.Socket.StartConnection()
	end
	
	function SquishLogs.Socket.Send(data)
		SquishLogs.Socket.Connection:write(util.TableToJSON(data))
	end

	print("[Squish Logs]", "Attempting to connect to", SquishLogs.Server.socket.name)
	SquishLogs.Socket.Connection:open()
end