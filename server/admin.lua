Admin = {}

-- Check if player is admin
function Admin:IsAdmin(src)
    local playerGroup = self:GetPlayerGroup(src)
    
    for _, adminGroup in ipairs(Config.AdminGroups) do
        if playerGroup == adminGroup then
            return true
        end
    end
    
    return false
end

-- Get player group (you may need to modify this based on your admin system)
function Admin:GetPlayerGroup(src)
    -- Check for god permission first
    if IsPlayerAceAllowed(src, 'god') then
        return 'god'
    end
    
    -- Check for admin permission
    if IsPlayerAceAllowed(src, 'admin') then
        return 'admin'
    end
    
    return 'user'
end

-- Initialize admin commands
CreateThread(function()
    Wait(1000)
    print('^2[Reputation]^7 Admin module initialized')
end)
