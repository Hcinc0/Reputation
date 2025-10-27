-- Event: Player Joined
AddEventHandler('playerJoining', function()
    local src = source
    Wait(5000) -- Wait for player to fully connect
    
    Database:GetPlayerData(src, function(playerData)
        if playerData then
            local trustFactor = playerData.trust_factor or Config.DefaultTrustFactor
            
            -- Chek kon tozihat zeman che player bayad ban beshe
            if trustFactor < Config.BanThreshold then
                DropPlayer(src, string.format('Shoma ban shodid! Trust Factor: %d (Had-e Min: %d)', trustFactor, Config.BanThreshold))
                return
            end
            
            -- Load shodan-e date player
            TrustFactor:LoadPlayer(src)
        else
            -- Javaye jadeed
            Database:CreatePlayer(src, Config.DefaultTrustFactor)
            TrustFactor:LoadPlayer(src)
        end
    end)
end)

-- Event: Player Disconnected
AddEventHandler('playerDropped', function(reason)
    local src = source
    TrustFactor:SavePlayerData(src)
end)

-- Command: Check Trust Factor
RegisterCommand('checktrust', function(source, args, rawCommand)
    local src = source
    
    if #args == 0 then
        -- Check own trust factor
        TriggerClientEvent('reputation:showOwnTrustFactor', src)
    else
        -- Admin check others (requires admin permission)
        if Admin:IsAdmin(src) then
            local targetSrc = tonumber(args[1])
            if targetSrc and GetPlayerName(targetSrc) then
                TriggerClientEvent('reputation:showTrustFactor', src, targetSrc, TrustFactor:Get(targetSrc))
            else
                TriggerClientEvent('ox_lib:notify', src, {
                    title = 'Khatay',
                    description = 'Player yaft nashod',
                    type = 'error'
                })
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Khatay',
                description = 'Shoma dastresi lazem ra nadarid',
                type = 'error'
            })
        end
    end
end, false)

-- Event: Update Trust Factor (called from admin commands)
RegisterNetEvent('reputation:updateTrustFactor')
AddEventHandler('reputation:updateTrustFactor', function(targetSrc, amount, reason)
    local src = source
    
    -- Chek kardan-e dastresieye admin
    if not Admin:IsAdmin(src) then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Khatay',
            description = 'Shoma dastresi lazem ra nadarid',
            type = 'error'
        })
        return
    end
    
    -- Update kardan-e trust factor
    local newTrust = TrustFactor:Update(targetSrc, amount, reason)
    
    -- Etelaa resani-ye admin
    TriggerClientEvent('ox_lib:notify', src, {
        title = 'Movafaghiat',
        description = string.format('Trust Factor be %d taghir dad', newTrust),
        type = 'success'
    })
    
    -- Etelaa resani-ye player-e hadaf
    if targetSrc then
        TriggerClientEvent('ox_lib:notify', targetSrc, {
            title = 'Trust Factor',
            description = string.format('Etebare shoma alan %+d hast (%d)', amount, newTrust),
            type = amount > 0 and 'success' or 'error'
        })
        
        -- Update kardan UI player bayni bahdam
        TriggerClientEvent('reputation:updateUITrustFactor', targetSrc, newTrust)
    end
    
    -- Chek kon tozihat che aya player bayad ban beshe
    if Config.EnableAutoBan and newTrust < Config.BanThreshold then
        DropPlayer(targetSrc, string.format('Trust Factor shoma kheili payin hast! (%d)', newTrust))
    end
end)

-- Event: Request Own Trust Factor
RegisterNetEvent('reputation:requestOwnTrustFactor')
AddEventHandler('reputation:requestOwnTrustFactor', function()
    local src = source
    local trustFactor = TrustFactor:Get(src)
    TriggerClientEvent('reputation:updateUITrustFactor', src, trustFactor)
end)

-- Load database on resource start
CreateThread(function()
    Database:Initialize()
    print('^2[Reputation]^7 Database initialized successfully')
end)

-- Initialize admin commands
CreateThread(function()
    Wait(1000)
    Admin:RegisterCommands()
    print('^2[Reputation]^7 Admin commands registered')
end)

print('^2[Reputation]^7 Server script loaded successfully')