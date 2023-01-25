local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

hook.Add("PostLoadData", "Squish_Logs_Helix_Int", function()

    local HANDLER = {}

    function HANDLER.Write(client, message, logFlag, logType)
        local chartxt = ""
        if IsValid(client:GetCharacter()) then
            chartxt = " CharID ".. client:GetCharacter():GetID()
        end

        SquishLog:New()
        :SetCategory("Helix | " .. logType)
        :AddFragment(client)
        :AddFragment( " " .. string.gsub(message, client:Nick(), ""))
        :SetFragmentColor(colorYellow)
        :AddFragment( chartxt )
        :Send()
    end

    ix.log.RegisterHandler("Squish_Logs", HANDLER)

end)
