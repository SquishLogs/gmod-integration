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
            print('body', body)
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