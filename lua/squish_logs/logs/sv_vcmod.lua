local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

hook.Add("VC_CD_playerPurchasedVehicle", "SquishLogs:Log:VCMod:CarDealer", function(ply, ID, price, NPC)
	if ((not IsValid(ply)) or (not ply:IsPlayer())) then return end

    SquishLog:New()
        :SetCategory("VCMod | Car Dealer")
        :AddFragment(ply)
        :AddFragment(' purchased vehicle ')
        :SetFragmentColor(colorBlue)
        :AddFragment(ID)
        :AddFragment(' for ')
        :SetFragmentColor(colorGreen)
        :AddFragment("$"..string.Comma(price))
        :Send()
end)
hook.Add("VC_CD_playerSoldVehicle", "SquishLogs:Log:VCMod:CarDealer", function(ply, ID, price, NPC)
	if ((not IsValid(ply)) or (not ply:IsPlayer())) then return end

    SquishLog:New()
        :SetCategory("VCMod | Car Dealer")
        :AddFragment(ply)
        :AddFragment(' sold vehicle ')
        :SetFragmentColor(colorBlue)
        :AddFragment(ID)
        :AddFragment(' for ')
        :SetFragmentColor(colorGreen)
        :AddFragment("$"..string.Comma(price))
        :Send()
end)
hook.Add("VC_CD_spawnedVehicle", "SquishLogs:Log:VCMod:CarDealer", function(ply, ent, test)
	if ((not IsValid(ply)) or (not ply:IsPlayer())) then return end

    local log = SquishLog:New()
        :SetCategory("VCMod | Car Dealer")
        :AddFragment(ply)

    if (test) then
        log = log:AddFragment(' has started test driving ')
    else
        log = log:AddFragment(' has spawned their vehicle ')
    end

    log:SetFragmentColor(colorBlue)
        :AddFragment(ent:GetVehicleClass())
        :Send()
end)
hook.Add("VC_partDamaged", "SquishLogs:Log:VCMod:Damage", function(ent, class, obj, att, inf)
	if ((not att) or (not att:IsPlayer())) then return end

    SquishLog:New()
        :SetCategory("VCMod | Damange")
        :SetFragmentColor(colorBlue)
        :AddFragment(ent:GetVehicleClass())
        :AddFragment('(')
        :AddFragment(ent:CPPIGetOwner())
        :AddFragment(') took damange from ')
        :AddFragment(att)
        :Send()
end)