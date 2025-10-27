-- UI Controller

local isUIVisible = false

-- NUI Callbacks
RegisterNUICallback('closeUI', function(data, cb)
    isUIVisible = false
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Show progress notification
function ShowTrustFactorNotification(trustFactor, change, reason)
    if not Config.EnableNotifications then return end
    
    local level = GetTrustFactorLevel(trustFactor)
    
    local notification = {
        title = 'Trust Factor Update',
        description = string.format('%d (%s)', trustFactor, level.name),
        type = change > 0 and 'success' or 'error',
        duration = 4000
    }
    
    if reason then
        notification.description = string.format('%s: %+d\n%s', reason, change, notification.description)
    end
    
    lib.notify(notification)
end

-- Color fade effect when trust factor changes
function FlashUI(color)
    SendNUIMessage({
        type = 'flash',
        color = color
    })
end

print('^2[Reputation]^7 UI script loaded successfully')
