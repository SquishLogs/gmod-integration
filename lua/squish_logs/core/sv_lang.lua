function SquishLogs:GetPhrase(phrase)
    local langData = SquishLogs:GetLanguage()
    if langData and langData[phrase] then
        return langData[phrase]
    else
        error("Unknown phrase: " .. phrase)
        return phrase
    end
end

function SquishLogs:GetLanguage()
    local url = "https://raw.githubusercontent.com/Hendalf-DEV/Squish-Logs-Lang/main/gmod/" .. SquishLogs.Language .. ".json"
    http.Fetch(url, function(body, size, headers, code)
        local langData = util.JSONToTable(body)
        return langData
    end, function(error)
        print("Failed to fetch language file: " .. error)
    end)
end
