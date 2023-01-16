// Start the system
hook.Add("InitPostEntity", "SquishLogs:Start", function()
    hook.Remove("InitPostEntity", "SquishLogs:Start")
    timer.Simple(2, function() // God am I happy I don't do this shit on a daily basis
        print("[Squish Logs]", "Attempting to find connection data")
    
        http.Fetch(SquishLogs.Info.Domain .. '/api/v1/server', function(body, _, _, code)
            if (!(code == 200)) then
                print("[Squish Logs]", "Invalid response code. Aborting.", code)
                return
            end
    
            print("[Squish Logs]", "Successfuly found server")
            if (!body) then
                print("[Squish Logs]", "Permission granted but returned result was unexpected. Aborting.")
                return
            end
    
            local json = util.JSONToTable(body);
            if (!json) then
                print("[Squish Logs]", "Permission granted but returned result was not JSON. Aborting.")
                return
            end
    
            SquishLogs.Server = json
            SquishLogs.Socket.StartConnection(location)
        end, function(error)
            print("[Squish Logs]", "Failed to find server")
            print(error)
        end, {
            ['X-Game-Server-Token'] = SquishLogs.Info.Token
        })
    end)
end)

hook.Add("PlayerInitialSpawn", "SquishLogs:Player", function(ply)
    SquishLogs.Core.RegisterPlayer(ply)
end)


// Set all current logs for this server as archived
function SquishLogs.Core.Archive()
    SquishLogs.Socket.Send({
        type = "archive"
    })
end

// Used to upsert the player
function SquishLogs.Core.RegisterPlayer(ply)
    if (!IsValid(ply) or !ply:IsPlayer()) then return end

    SquishLogs.Socket.Send({
        type = "player",
        player = {
            name = ply.SteamName and ply:SteamName() or ply:Nick(),
            platform_id = ply:SteamID64()
        }
    })
end

// Send a simple log
function SquishLogs.Core.SimpleLog(message, category)
    if (!message) then return end

    SquishLog:New()
        :SetCategory(category or "System")
        :AddFragment(message)
        :Send()
end

util.AddNetworkString("SquishLogs:Command")

hook.Add("PlayerSay", "SquishLogs:ChatCommand", function(ply, text)
    if (!(string.lower(text) == "!logs")) then return end

    net.Start("SquishLogs:Command")
    net.Send(ply)
end)
