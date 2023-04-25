local colorYellow = Color(146,138,64)
local colorGreen = Color(34,139,34)
local colorRed = Color(200, 0, 0)
local colorBlue = Color(29, 97, 129)

// CAMI Stuff
hook.Add("CAMI.OnUsergroupRegistered", "SquishLogs:Log:CAMI:Usergroup", function(usergroup, source)
    if ((not usergroup) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment(SquishLogs:GetPhrase("new_usergroup"))
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup.Name)
        :AddFragment(SquishLogs:GetPhrase("was_created"))
        :Send()
end)

hook.Add("CAMI.OnUsergroupUnregistered", "SquishLogs:Log:CAMI:Usergroup", function(usergroup, source)
    if ((not usergroup) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment(SquishLogs:GetPhrase("usergroup"))
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup.Name)
        :AddFragment(SquishLogs:GetPhrase("was_deleted"))
        :Send()
end)

hook.Add("CAMI.PlayerUsergroupChanged", "SquishLogs:Log:CAMI:Usergroup", function(ply, old, new, source)
    if ((not ply) or (not old) or (not new) or (not source)) then return end

    SquishLog:New()
        :SetCategory(source.." | Usergroup")
        :AddFragment(ply)
        :AddFragment(SquishLogs:GetPhrase("usergroup_changed"))
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
        :AddFragment(admin or SquishLogs:GetPhrase("console"))
        :AddFragment(SquishLogs:GetPhrase("kick"))
        :AddFragment(target)
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :Send()
end)

hook.Add("xAdminPlayerBanned", "SquishLogs:Log:xAdmin:Ban", function(target, admin, reason, time)
    if ((not target) or (not admin) or (not reason) or (not time)) then return end

    SquishLog:New()
        :SetCategory("xAdmin | Punishment")
        :AddFragment(admin or SquishLogs:GetPhrase("console"))
        :AddFragment(SquishLogs:GetPhrase("banned"))
        :SetFragmentColor(colorGreen)
        :AddFragment(target)
        :AddFragment(SquishLogs:GetPhrase("for"))
        :SetFragmentColor(colorRed)
        :AddFragment(reason)
        :AddFragment(SquishLogs:GetPhrase("length"))
        :SetFragmentColor(colorBlue)
        :AddFragment((time==0 and xAdmin.Config.StrForPermBan) or string.NiceTime(time))
        :Send()
end)

hook.Add("xAdminPlayerUnBanned", "SquishLogs:Log:xAdmin:Unban", function(target, admin)
    if ((not target) or (not admin)) then return end

    SquishLog:New()
        :SetCategory("xAdmin | Punishment")
        :AddFragment(admin or SquishLogs:GetPhrase("console"))
        :AddFragment(SquishLogs:GetPhrase("unbanned"))
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
        :AddFragment(SquishLogs:GetPhrase("usergroup_changed"))
        :SetFragmentColor(colorBlue)
        :AddFragment(usergroup)
        :Send()
end)
