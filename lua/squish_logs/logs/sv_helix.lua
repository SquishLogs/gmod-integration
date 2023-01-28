local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

hook.Add("PostLoadData", "SquishLogs:Log:Helix", function()
    // Check that Helix is installed
    if (!ix) then return end

    local HANDLER = {}

    function HANDLER.Write(client, message, logFlag, logType)
        local chartxt = ""

        if client:GetCharacter() then
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
