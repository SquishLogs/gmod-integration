function SquishLogs:GetPhrase(key)
    local sentence = SquishLogs.Translations[key]
    if sentence ~= "" then
        return sentence
    else
        return "No translation available for key: " .. key
    end
end
