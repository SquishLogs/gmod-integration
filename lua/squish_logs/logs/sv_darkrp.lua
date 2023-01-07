local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

hook.Add("playerAdverted", "SquishLogs:Log:DarkRP:Advert", function(ply, args, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("DarkRP | Advert")
        :AddFragment(ply)
        :AddFragment(' adverted ')
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
        :AddFragment(' used a battering ram on a door owned by ')
        :AddFragment(IsValid(doorPly) and doorPly or "Unknown")
        :Send()
end)

hook.Add("playerDroppedCheque", "SquishLogs:Log:DarkRP:Cheque", function(ply, ply2, amount)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(' wrote a cheque for ')
        :AddFragment(ply2)
        :AddFragment(' at the amount of ')
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
        :AddFragment(' picked up a cheque from ')
        :AddFragment(ply2)
        :AddFragment(' for the amount of ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("onChatCommand", "SquishLogs:Log:DarkRP:ChatCommand", function(ply, command)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Chat Command")
        :AddFragment(ply)
        :AddFragment(' ran command ')
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
        :AddFragment(' demoted ')
        :AddFragment(ply2)
        :AddFragment(' for ')
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerBoughtDoor", "SquishLogs:Log:DarkRP:Door", function(ply, ent, cost)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Door")
        :AddFragment(ply)
        :AddFragment(' purchased a door for ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(cost))
        :Send()
end)

hook.Add("playerSellDoor", "SquishLogs:Log:DarkRP:Door", function(ply, ent, cost)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Door")
        :AddFragment(ply)
        :AddFragment(' sold a door')
        :Send()
end)

hook.Add("playerDroppedMoney", "SquishLogs:Log:DarkRP:Economy", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(' dropped ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("playerPickedUpMoney", "SquishLogs:Log:DarkRP:Economy", function(ply, amount, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(' picked up ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(amount))
        :Send()
end)

hook.Add("OnPlayerChangedTeam", "SquishLogs:Log:DarkRP:Player", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(' has changed their job from ')
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
        :AddFragment('A law was added: ')
        :SetFragmentColor(colorYellow)
        :AddFragment(law)
        :Send()
end)

hook.Add("removeLaw", "SquishLogs:Log:DarkRP:Law", function(index, law)
    SquishLog:New()
        :SetCategory("DarkRP | Law")
        :AddFragment('A law was removed: ')
        :SetFragmentColor(colorYellow)
        :AddFragment(law)
        :Send()
end)

hook.Add("lockpickStarted", "SquishLogs:Log:DarkRP:Lockpick", function(ply, ent)
	if (not IsValid(ply)) or (not ply:IsPlayer()) or (not IsValid(ent)) then return end

    local log =SquishLog:New()
        :SetCategory("DarkRP | Lockpick")
        :AddFragment(ply)
        :AddFragment(' started picking ')

	if ent:IsVehicle() then
        log = log:SetFragmentColor(colorBlue)
            :AddFragment(ent:GetVehicleClass())
            :AddFragment(' (')
            :AddFragment(ent:CPPIGetOwner())
            :AddFragment(')')
	else
        log = log:AddFragment(ent:GetClass())
	end

    log:send()
end)

hook.Add("onLockpickCompleted", "SquishLogs:Log:DarkRP:Lockpick", function(ply, success, ent)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ent) then return end

    local log =SquishLog:New()
        :SetCategory("DarkRP | Lockpick")
        :AddFragment(ply)
        :AddFragment(' finished picking ')

	if ent:IsVehicle() then
        log = log:SetFragmentColor(colorBlue)
            :AddFragment(ent:GetVehicleClass())
            :AddFragment(' (')
            :AddFragment(ent:CPPIGetOwner())
            :AddFragment(')')
	else
        log = log:AddFragment(ent:GetClass())
	end

    log:send()
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
        :AddFragment(' purchased entity ')
        :SetFragmentColor(colorYellow)
        :AddFragment(entprintname)
        :AddFragment(' for ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(price))
        :Send()
end)

hook.Add("playerBoughtShipment", "SquishLogs:Log:DarkRP:Economy", function(ply, entTable, ent, price)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Economy")
        :AddFragment(ply)
        :AddFragment(' purchased shipment ')
        :SetFragmentColor(colorYellow)
        :AddFragment(entTable.name or "Unknown")
        :AddFragment(' for ')
        :SetFragmentColor(colorGreen)
        :AddFragment(DarkRP.formatMoney(price))
        :Send()
end)

hook.Add("onPlayerChangedName", "SquishLogs:Log:DarkRP:Player", function(ply, before, after)
	if not IsValid(ply) or not ply:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(' changed their name from ')
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
        :AddFragment(' has made ')
        :AddFragment(ply)
        :AddFragment(' wanted for ')
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerUnWanted", "SquishLogs:Log:DarkRP:Player", function(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(' is no longer wanted')
        :Send()
end)

hook.Add("playerWarranted", "SquishLogs:Log:DarkRP:Player", function(ply, ply2, reason)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not IsValid(ply2) or not ply2:IsPlayer() then return end
    
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply2)
        :AddFragment(' has issued a warrant on ')
        :AddFragment(ply)
        :AddFragment(' for ')
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("playerUnWarranted", "SquishLogs:Log:DarkRP:Player", function(ply)
    SquishLog:New()
        :SetCategory("DarkRP | Player")
        :AddFragment(ply)
        :AddFragment(' no longer has a warrant')
        :Send()
end)