require("gwsockets")

function SquishLogs.Socket.StartConnection()
	print("[Squish Logs]", "Starting websocket connection")

	if SquishLogs.Socket.Connection then
		SquishLogs.Socket.Connection:closeNow()
	end

	SquishLogs.Socket.Connection = GWSockets.createWebSocket("ws://" .. SquishLogs.Server.socket.ip_address, false)

	function SquishLogs.Socket.Connection:onMessage(txt)
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
		print('SquishLogs.Socket.Send')
		SquishLogs.Socket.Connection:write(util.TableToJSON(data))
	end

	print("[Squish Logs]", "Attempting to connect to", SquishLogs.Server.socket.name)
	SquishLogs.Socket.Connection:open()
end