// Basic stuff
SquishLog = {}
SquishLog.__index = SquishLog
SquishLog.category = "Other"
SquishLog.log = {}
SquishLog._color = nil
SquishLog._meta = nil

function SquishLog:New()
    local tbl = setmetatable({}, SquishLog)
    tbl.category = "Other"
    tbl.log = {}
    tbl._color = nil
    tbl._meta = nil
    
    return tbl
end

function SquishLog:formatColor(color)
    if (!IsColor(color)) then return nil end

    return color.r .. ',' .. color.g .. ',' .. color.b
end

// Category
function SquishLog:SetCategory(category)
    self.category = category

    return self
end
function SquishLog:GetCategory()
    return self.category
end

// Log
function SquishLog:AddFragment(fragment)
    if (!fragment) then return self end
    
    local fragType = type(fragment)
    local data = {};

    if (fragType == "Player") then
        data = {
            type = "player",
            data = {
                name = fragment:Nick(),
                platform_name = fragment.SteamName and fragment:SteamName() or fragment:Nick(),
                platform_id = fragment:SteamID64(),
                health = fragment:Health(),
                weapon = {
                    name = (IsValid(fragment:GetActiveWeapon()) and fragment:GetActiveWeapon():GetPrintName()) or "Unknown",
                    class = (IsValid(fragment:GetActiveWeapon()) and fragment:GetActiveWeapon():GetClass()) or "Unknown"
                },
                team = {
                    name = team.GetName(fragment:Team()),
                    color = SquishLog:formatColor(team.GetColor(fragment:Team()))
                }
            }
        }
    elseif ((fragType == "string") or (fragType == "number")) then
        data = {
            type = "text",
            data = {
                text = fragment,
                color = SquishLog:formatColor(self._color),
                meta = self._meta and table.Copy(self._meta) or NULL
            }
        }
    else
        print("[Squish Logs]", "Log received bad data. Aborting.", fragType)
        return self
    end

    table.insert(self.log, data)
    self._color = nil;
    self._meta = nil;

    return self
end
function SquishLog:SetFragmentColor(color)
    self._color = color

    return self
end
function SquishLog:SetFragmentMeta(meta)
    self._meta = meta

    return self
end

// Send the log
function SquishLog:Send()
    SquishLogs.Socket.Send({
        type = "log",
        category = self.category,
        log = self.log
    })
end