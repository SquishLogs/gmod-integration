local function loadTranslationTable(language)
    timer.Simple(0, function()
        http.Fetch("https://raw.githubusercontent.com/SquishLogs/translations/main/gmod/" .. language .. ".json", function(response)
            if response then
                SquishLogs.Translations = util.JSONToTable(response)
            else
                print("Failed to retrieve translation table for language: " .. language)
            end
        end)
    end)
end

loadTranslationTable(SquishLogs.Language)
