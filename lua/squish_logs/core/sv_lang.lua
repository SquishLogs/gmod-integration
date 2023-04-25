function SquishLogs:GetPhrase(key)
    local sentence = SquishLogs.Translations[key]
    if sentence ~= "" then
        return sentence
    else
        return "No translation available for key: " .. key
    end
end

local function loadTranslationTable(language)
    timer.Simple(0, function()
        http.Fetch("https://raw.githubusercontent.com/Hendalf-DEV/Squish-Logs-Lang/main/gmod/" .. language .. ".json", function(response)
            if response then
                SquishLogs.Translations = util.JSONToTable(response)
                SquishLogs.TranslationsLoaded = true
            else
                print("Failed to retrieve translation table for language: " .. language)
            end
        end)
    end)
end

-- Call load function to load the translation table from the internet if necessary
if not SquishLogs.TranslationsLoaded then
    loadTranslationTable(SquishLogs.Language)
end
