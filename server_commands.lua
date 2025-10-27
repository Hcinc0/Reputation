-- Server Commands for Reputation System

-- Command: Add Trust Factor
RegisterCommand('addtrust', function(source, args, rawCommand)
    local src = source
    
    if not Admin:IsAdmin(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Khatay',
            description = 'Shoma dastresy nadarid',
            type = 'error'
        })
        return
    end
    
    if #args < 2 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Estefadeh',
            description = '/addtrust [id] [amount] [reason]',
            type = 'info'
        })
        return
    end
    
    local targetSrc = tonumber(args[1])
    local amount = tonumber(args[2])
    local reason = table.concat(args, ' ', 3) or 'Admin command'
    
    if not GetPlayerName(targetSrc) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Error',
            description = 'Player peyda nashod',
            type = 'error'
        })
        return
    end
    
    TriggerEvent('reputation:updateTrustFactor', targetSrc, amount, reason)
end, false)

-- Command: Remove Trust Factor
RegisterCommand('removetrust', function(source, args, rawCommand)
    local src = source
    
    if not Admin:IsAdmin(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Khatay',
            description = 'Shoma dastresy nadarid',
            type = 'error'
        })
        return
    end
    
    if #args < 2 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Estefadeh',
            description = '/removetrust [id] [amount] [reason]',
            type = 'info'
        })
        return
    end
    
    local targetSrc = tonumber(args[1])
    local amount = tonumber(args[2]) * -1  -- Make it negative
    local reason = table.concat(args, ' ', 3) or 'Admin penalty'
    
    if not GetPlayerName(targetSrc) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Error',
            description = 'Player peyda nashod',
            type = 'error'
        })
        return
    end
    
    TriggerEvent('reputation:updateTrustFactor', targetSrc, amount, reason)
end, false)

-- Command: Set Trust Factor
RegisterCommand('settrust', function(source, args, rawCommand)
    local src = source
    
    if not Admin:IsAdmin(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Khatay',
            description = 'Shoma dastresy nadarid',
            type = 'error'
        })
        return
    end
    
    if #args < 2 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Estefadeh',
            description = '/settrust [id] [value]',
            type = 'info'
        })
        return
    end
    
    local targetSrc = tonumber(args[1])
    local targetValue = tonumber(args[2])
    
    if not GetPlayerName(targetSrc) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Error',
            description = 'Player peyda nashod',
            type = 'error'
        })
        return
    end
    
    local currentTrust = TrustFactor:Get(targetSrc)
    local difference = targetValue - currentTrust
    
    TriggerEvent('reputation:updateTrustFactor', targetSrc, difference, 'Admin set')
end, false)

-- Command: List top players
RegisterCommand('toptrust', function(source, args, rawCommand)
    local src = source
    
    if not Admin:IsAdmin(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Khatay',
            description = 'Shoma dastresy nadarid',
            type = 'error'
        })
        return
    end
    
    Database:GetAllPlayersData(function(allData)
        local message = '^3=== Top 10 Trust Factor Players ===^7\n\n'
        for i = 1, math.min(10, #allData) do
            local data = allData[i]
            local level = TrustFactor:GetLevel(data.trust_factor)
            message = message .. string.format('^%d. ^4%s^7 - ^2%d^7 (%s)\n', i, data.identifier, data.trust_factor, level.name)
        end
        print(message)
        
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Top Trust Factor',
            description = 'Natayeje dar console neshan dade shod',
            type = 'inform',
            duration = 4000
        })
    end)
end, false)

-- Command: Show top 10 players to all players
RegisterCommand('leaderboard', function(source, args, rawCommand)
    local src = source
    
    Database:GetAllPlayersData(function(allData)
        local message = '^3=== Top 10 Trust Factor Players ===^7\n\n'
        for i = 1, math.min(10, #allData) do
            local data = allData[i]
            local level = TrustFactor:GetLevel(data.trust_factor)
            message = message .. string.format('^%d. ^4%s^7 - ^2%d^7 (%s)\n', i, data.identifier, data.trust_factor, level.name)
        end
        print(message)
        
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Top Trust Factor',
            description = 'Natayeje dar console neshan dade shod',
            type = 'inform',
            duration = 4000
        })
    end)
end, false)
