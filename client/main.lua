-- Client-side Main Script

local currentTrustFactor = Config.DefaultTrustFactor
local showUI = false

-- Initialize UI
CreateThread(function()
    Wait(2000)
    showUI = true
    RequestTrustFactor()
end)

-- Request trust factor from server
function RequestTrustFactor()
    TriggerServerEvent('reputation:requestOwnTrustFactor')
end

-- Update UI with trust factor
RegisterNetEvent('reputation:updateUITrustFactor')
AddEventHandler('reputation:updateUITrustFactor', function(trustFactor)
    currentTrustFactor = trustFactor
    updateUI(trustFactor)
end)

-- Update UI display
function updateUI(trustFactor)
    local level = GetTrustFactorLevel(trustFactor)
    local progress = ((trustFactor - level.min) / (level.max - level.min)) * 100
    
    SendNUIMessage({
        type = 'update',
        trustFactor = trustFactor,
        levelName = level.name,
        levelColor = level.color,
        progress = progress
    })
end

-- Get trust factor level
function GetTrustFactorLevel(trustFactor)
    for _, level in ipairs(Config.TrustFactorLevels) do
        if trustFactor >= level.min and trustFactor <= level.max then
            return level
        end
    end
    return Config.TrustFactorLevels[#Config.TrustFactorLevels]
end

-- Show own trust factor
RegisterNetEvent('reputation:showOwnTrustFactor')
AddEventHandler('reputation:showOwnTrustFactor', function()
    local level = GetTrustFactorLevel(currentTrustFactor)
    
    lib.notify({
        title = 'Trust Factor-e Shoma',
        description = string.format('%d (%s)', currentTrustFactor, level.name),
        type = 'inform',
        duration = 5000
    })
end)

-- Show others' trust factor (admin only)
RegisterNetEvent('reputation:showTrustFactor')
AddEventHandler('reputation:showTrustFactor', function(targetSrc, trustFactor)
    local playerName = GetPlayerName(targetSrc)
    local level = GetTrustFactorLevel(trustFactor)
    
    lib.notify({
        title = string.format('Trust Factor: %s', playerName),
        description = string.format('%d (%s)', trustFactor, level.name),
        type = 'inform',
        duration = 5000
    })
end)

-- Refresh trust factor periodically
CreateThread(function()
    while true do
        Wait(Config.UIRefreshRate)
        if showUI then
            RequestTrustFactor()
        end
    end
end)

-- Toggle UI with keybind (F3)
RegisterKeyMapping('toggleReputation', 'Toggle Reputation UI', 'keyboard', 'F3')
RegisterCommand('toggleReputation', function()
    showUI = not showUI
    SendNUIMessage({
        type = 'toggle',
        show = showUI
    })
end, false)

print('^2[Reputation]^7 Client script loaded successfully')
