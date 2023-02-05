local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

// CAMI Stuff
hook.Add("CAMI.OnUsergroupRegistered", "SquishLogs:Log:CAMI:Usergroup", function(usergroup, source)
    if ((not usergroup) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment('A new usergroup called ')
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup.Name)
        :AddFragment(' was created')
        :Send()
end)

hook.Add("CAMI.OnUsergroupUnregistered", "SquishLogs:Log:CAMI:Usergroup", function(usergroup, source)
    if ((not usergroup) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment('The usergroup ')
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup.Name)
        :AddFragment(' was deleted')
        :Send()
end)

hook.Add("CAMI.PlayerUsergroupChanged", "SquishLogs:Log:CAMI:Usergroup", function(ply, old, new, source)
    if ((not ply) or (not old) or (not new) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment(ply)
        :AddFragment(' has had their user group changed from ')
        :SetFragmentColor(colorRed)
        :AddFragment(old)
        :AddFragment(' -> ')
        :SetFragmentColor(colorBlue)
        :AddFragment(new)
        :Send()
end)

// xAdminGithub Specific
hook.Add("xAdminPlayerKicked", "SquishLogs:Log:xAdmin:Kick", function(target, admin, reason)
    if ((not admin) or (not target) or (not reason)) then return end

    SquishLog:New()
        :SetCategory("xAdmin | Punishment")
        :AddFragment(admin or 'Console')
        :AddFragment(' kicked ')
        :AddFragment(target)
        :AddFragment(' for ')
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("xAdminPlayerBanned", "SquishLogs:Log:xAdmin:Ban", function(target, admin, reason, time)
    if ((not target) or (not admin) or (not reason) or (not time)) then return end

    SquishLog:New()
        :SetCategory("xAdmin | Punishment")
        :AddFragment(admin or 'Console')
        :AddFragment(' banned ')
        :SetFragmentColor(colorGreen)
        :AddFragment(target)
        :AddFragment(' for ')
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :AddFragment(' at a length of ')
        :SetFragmentColor(colorBlue)
        :AddFragment((time==0 and xAdmin.Config.StrForPermBan) or string.NiceTime(time))
        :Send()
end)

hook.Add("xAdminPlayerUnBanned", "SquishLogs:Log:xAdmin:Unban", function(target, admin)
    if ((not target) or (not admin)) then return end

    SquishLog:New()
        :SetCategory("xAdmin | Punishment")
        :AddFragment(admin or 'Console')
        :AddFragment(' unbanned ')
        :SetFragmentColor(colorGreen)
        :AddFragment(target)
        :Send()
end)

hook.Add("xAdminUsergroupUpdated", "SquishLogs:Log:xAdmin:Usergroup", function(target, usergroup)
    if ((not target) or (not usergroup)) then return end

	local target, targetPly = xAdmin.Core.GetID64(target)

    SquishLog:New()
        :SetCategory("xAdmin | Usergroup")
        :AddFragment((IsValid(targetPly) and targetPly) or target)
        :AddFragment(' has had their user group changed to ')
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup)
        :Send()
end)