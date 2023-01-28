hook.Add('SquishLogs:Send', 'SquishLogs:Discord', function(data)
    if (!data or !(data.type == 'log')) then return end
    if (!SquishLogs.Server.discord_webhook) then return end

    if(!reqwest) then 
        if(!util.IsBinaryModuleInstalled("reqwest")) then
            print("reqwest is not installed! This module is required for discord webhooks!")
            print("Without it, your discord webhook will not work!")
            print("Get it here: https://github.com/WilliamVenner/gmsv_reqwest")
            print("More information here: https://docs.squish.wtf/garrys-mod/discord-integration")
            
            hook.Remove("SquishLogs:Send", "SquishLogs:Discord")
            return
        end
        require("reqwest")
    end

    // Get the color in annoying Discord required format :)
    if (!SquishLogs.Server.color_discord) then
        local _, r, g, b = string.match(SquishLogs.Server.color, '(.)(..)(..)(..)')
        r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
        r, g, b = math.floor(r*100)/100, math.floor(g*100)/100, math.floor(b*100)/100

        SquishLogs.Server.color_discord = tonumber("0x"..string.format("%02x%02x%02x", r, g, b))
    end

    local log = {
        title = data.category,
        color = SquishLogs.Server.color_discord,
        description = "",
        fields = {},
        footer = {
            text = "Powered by Squish Logs"
        }
    };

    // Build the log out in a text form
    for k, v in ipairs(data.log) do
        if (v.type == 'text') then
            log.description = log.description .. v.data.text
        elseif (v.type == 'player') then
            log.description = log.description .. v.data.name

            // Add the user's data to the fields
            table.insert(log.fields, {
                name = v.data.name,
                value = "Health: "..v.data.health.." | Weapon: "..(v.data.weapon and v.data.weapon.name or "Unknown").." | Team: "..(v.data.team and v.data.team.name or "Unknown").." | ID: "..v.data.platform_id
            })
        end
    end

    reqwest({
        method = "POST",
        headers = {
            ["User-Agent"] = "GarrysMod/SquishLogs",
            ["Content-Type"] = "application/json"
        },
        url = SquishLogs.Server.discord_webhook,
        body = util.TableToJSON({embeds = {log}}),
    })
end)