function SquishLogs:GetPhrase(phrase, callback)
    if not self.languageData then
        local url = "https://raw.githubusercontent.com/Hendalf-DEV/Squish-Logs-Lang/main/gmod/" .. self.Language .. ".json"
        http.Fetch(url, function(body, size, headers, code)
            self.languageData = util.JSONToTable(body)
            local result = self.languageData[phrase] or phrase
            callback(result)
        end, function(error)
            print("Failed to fetch language file: " .. error)
            callback(phrase)
        end)
    else
        local result = self.languageData[phrase] or phrase
        callback(result)
    end
end
