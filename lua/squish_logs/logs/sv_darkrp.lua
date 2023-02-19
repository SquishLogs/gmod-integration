local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

hook.Add("playerAdverted", "SquishLogs:Log:DarkRP:Advert", function(ply, args, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("DarkRP | Advert")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("advert"))
        :SetFragmentColor(colorYellow)
        :AddFragment(args)
        :Send()
end)

hook.Add("onDoorRamUsed", "SquishLogs:Log:DarkRP:BatteringRam", function(success, ply, trace)
    if (not success) then return end
	if not IsValid(ply) or not ply:IsPlayer() then return end
	local doorPly = trace.Entity:getDoorOwner()

    SquishLog:New()
        :SetCategory("DarkRP | Battering Ram")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("bar_used"))
        :AddFragment(IsValid(doorPly) and doorPly or "Unknown")
        :Send()
end)

hook.Add("playerDroppedCheque", "SquishLogs:Log:DarkRP:Cheque", function(ply, ply2, amount)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("cheque"))
        :AddFragment(ply2)
        :AddFragment(SquishLogs:GetPhrase("at_amount"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("playerPickedUpCheque", "SquishLogs:Log:DarkRP:Cheque", function(ply, ply2, amount)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("cheque_pick"))
        :AddFragment(ply2)
        :AddFragment(SquishLogs:GetPhrase("amount"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("onChatCommand", "SquishLogs:Log:DarkRP:ChatCommand", function(ply, command)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Chat Command")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("command"))
        :SetFragmentColor(colorRed)
        :AddFragment(command)
        :Send()
end)

hook.Add("onPlayerDemoted", "SquishLogs:Log:DarkRP:Player", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("demote"))
        :AddFragment(ply2)
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerBoughtDoor", "SquishLogs:Log:DarkRP:Door", function(ply, ent, cost)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Door")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("door_pur"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(cost))
        :Send()
end)

hook.Add("playerSellDoor", "SquishLogs:Log:DarkRP:Door", function(ply, ent, cost)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Door")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("door_sell"))
        :Send()
end)

hook.Add("playerDroppedMoney", "SquishLogs:Log:DarkRP:Economy", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("drop"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("playerPickedUpMoney", "SquishLogs:Log:DarkRP:Economy", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("pick_up"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("OnPlayerChangedTeam", "SquishLogs:Log:DarkRP:Player", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("job_change"))
        :SetFragmentColor(team.GetColor(before))
        :AddFragment(team.GetName(before))
        :AddFragment(' -> ')
        :SetFragmentColor(team.GetColor(after))
        :AddFragment(team.GetName(after))
        :Send()
end)

hook.Add("addLaw", "SquishLogs:Log:DarkRP:Law", function(index, law)
    SquishLog:New()
        :SetCategory("DarkRP | Law")
        :AddFragment(SquishLogs:GetPhrase("law_add"))
        :SetFragmentColor(colorYellow)
        :AddFragment(law)
        :Send()
end)

hook.Add("removeLaw", "SquishLogs:Log:DarkRP:Law", function(index, law)
    SquishLog:New()
        :SetCategory("DarkRP | Law")
        :AddFragment(SquishLogs:GetPhrase("law_remove"))
        :SetFragmentColor(colorYellow)
        :AddFragment(law)
        :Send()
end)

hook.Add("lockpickStarted", "SquishLogs:Log:DarkRP:Lockpick", function(ply, ent)
	if (not IsValid(ply)) or (not ply:IsPlayer()) or (not IsValid(ent)) then return end

    local log =SquishLog:New()
        :SetCategory("DarkRP | Lockpick")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("picking"))

	if ent:IsVehicle() then
        log = log:SetFragmentColor(colorBlue)
            :AddFragment(ent:GetVehicleClass())
            :AddFragment(' (')
            :AddFragment(ent:CPPIGetOwner())
            :AddFragment(')')
	else
        log = log:AddFragment(ent:GetClass())
	end

    log:Send()
end)

hook.Add("onLockpickCompleted", "SquishLogs:Log:DarkRP:Lockpick", function(ply, success, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ent) then return end

    local log =SquishLog:New()
        :SetCategory("DarkRP | Lockpick")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("finish"))

	if ent:IsVehicle() then
        log = log:SetFragmentColor(colorBlue)
            :AddFragment(ent:GetVehicleClass())
            :AddFragment(' (')
            :AddFragment(ent:CPPIGetOwner())
            :AddFragment(')')
	else
        log = log:AddFragment(ent:GetClass())
	end

    log:Send()
end)

hook.Add("playerBoughtCustomEntity", "SquishLogs:Log:DarkRP:Economy", function(ply, entTable, ent, price)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local entprintname = ""
	if (IsValid(ent)) then
		local entTable = ent:GetTable()
		if (entTable) then
			entprintname = entTable.PrintName or entTable.name
		end
	end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("ent_pur"))
        :SetFragmentColor(colorYellow)
        :AddFragment(entprintname)
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(price))
        :Send()
end)

hook.Add("playerBoughtShipment", "SquishLogs:Log:DarkRP:Economy", function(ply, entTable, ent, price)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("ship_pur"))
        :SetFragmentColor(colorYellow)
        :AddFragment(entTable.name or "Unknown")
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(price))
        :Send()
end)

hook.Add("onPlayerChangedName", "SquishLogs:Log:DarkRP:Player", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("name_change"))
        :SetFragmentColor(colorYellow)
        :AddFragment(before)
        :AddFragment(' -> ')
        :SetFragmentColor(colorBlue)
        :AddFragment(after)
        :Send()
end)

hook.Add("playerWanted", "SquishLogs:Log:DarkRP:Player", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply2)
        :AddFragment(SquishLogs:GetPhrase("made"))
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("wanted"))
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerUnWanted", "SquishLogs:Log:DarkRP:Player", function(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("no_wanted"))
        :Send()
end)

hook.Add("playerWarranted", "SquishLogs:Log:DarkRP:Player", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply2)
        :AddFragment(SquishLogs:GetPhrase("warrant"))
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerUnWarranted", "SquishLogs:Log:DarkRP:Player", function(ply)
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("no_warrant"))
        :Send()
end)
