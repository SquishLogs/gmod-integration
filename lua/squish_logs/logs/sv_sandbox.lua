local colorGreen = Color(29, 129, 67)

hook.Add("PlayerSpawnedProp", "SquishLogs:Log:Sandbox:Spawn", function(ply, model)
	if not IsValid(ply) or not ply:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("Sandbox | Props")
        :AddFragment(ply)
        :AddFragment(' spawned ')
        :SetFragmentColor(colorGreen)
        :AddFragment(model)
        :Send()
end)

hook.Add("CanTool", "SquishLogs:Log:Sandbox:Toolgun", function(ply, tr, tool)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("Sandbox | Toolgun")
        :AddFragment(ply)
        :AddFragment(' used ')
        :SetFragmentColor(colorGreen)
        :AddFragment(tool)
        :Send()
end)
