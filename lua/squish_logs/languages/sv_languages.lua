local lang = include(SquishLogs.Language .. ".lua")

function SquishLogs:GetPhrase(phrase)
    if not lang[phrase] then
        error("Unknown phrase: " .. phrase)
        return phrase
    end
    return lang[phrase]
end
