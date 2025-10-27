TrustFactor = {}

-- Cache for online players
local playerCache = {}

-- Get trust factor from cache or database
function TrustFactor:Get(src)
    if playerCache[src] then
        return playerCache[src].trust_factor
    end
    
    local defaultTrust = Config.DefaultTrustFactor
    playerCache[src] = {
        trust_factor = defaultTrust,
        last_update = os.time()
    }
    
    return defaultTrust
end

-- Update trust factor
function TrustFactor:Update(src, amount, reason)
    local currentTrust = self:Get(src)
    local newTrust = math.max(Config.MinTrustFactor, math.min(Config.MaxTrustFactor, currentTrust + amount))
    
    -- Update cache
    playerCache[src] = {
        trust_factor = newTrust,
        last_update = os.time()
    }
    
    -- Update database immediately
    Database:UpdateTrustFactor(src, newTrust)
    
    -- Log action
    if Config.LogToFile then
        self:LogAction(src, amount, reason, newTrust)
    end
    
    -- Notify all admins
    self:NotifyAdmins(src, amount, reason, newTrust)
    
    return newTrust
end

-- Get trust factor level
function TrustFactor:GetLevel(trustFactor)
    for _, level in ipairs(Config.TrustFactorLevels) do
        if trustFactor >= level.min and trustFactor <= level.max then
            return level
        end
    end
    return Config.TrustFactorLevels[#Config.TrustFactorLevels]
end

-- Load player data when connected
function TrustFactor:LoadPlayer(src)
    Database:GetPlayerData(src, function(playerData)
        if playerData then
            playerCache[src] = {
                trust_factor = playerData.trust_factor,
                last_update = os.time()
            }
        end
    end)
end

-- Save player data
function TrustFactor:SavePlayerData(src)
    if playerCache[src] then
        Database:UpdateTrustFactor(src, playerCache[src].trust_factor)
        playerCache[src] = nil
    end
end

-- Log action to file
function TrustFactor:LogAction(src, amount, reason, newTrust)
    local playerName = GetPlayerName(src)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local logMessage = string.format('[%s] %s: %+d (%s) -> New TF: %d\n', timestamp, playerName, amount, reason or 'No reason', newTrust)
    
    -- Here you would typically write to a file
    -- For now, just print
    print('^3[Reputation]^7 ' .. logMessage)
end

-- Notify all admins about trust factor changes
function TrustFactor:NotifyAdmins(src, amount, reason, newTrust)
    local playerName = GetPlayerName(src)
    
    for _, playerId in ipairs(GetPlayers()) do
        local srcId = tonumber(playerId)
        if srcId and Admin:IsAdmin(srcId) then
            TriggerClientEvent('ox_lib:notify', srcId, {
                title = 'Trust Factor Update',
                description = string.format('%s: %s (TF: %d)', playerName, reason or 'No reason', newTrust),
                type = amount < 0 and 'error' or 'success',
                duration = 5000
            })
        end
    end
end

-- Auto-save data periodically
CreateThread(function()
    while true do
        Wait(300000) -- Every 5 minutes
        
        for src, data in pairs(playerCache) do
            if data then
                Database:UpdateTrustFactor(src, data.trust_factor)
            end
        end
    end
end)
