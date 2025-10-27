-- QBCore Integration (Optional)
-- Uncomment and modify if using QBCore

--[[
local QBCore = exports['qb-core']:GetCoreObject()

-- Get player group from QBCore
function Admin:GetPlayerGroup(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        return Player.PlayerData.job.name
    end
    return 'user'
end

-- Update get identifier for QBCore
function Database:GetIdentifier(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        return Player.PlayerData.license
    end
    return false
end
]]

--[[
To use with QBCore:
1. Uncomment the code above
2. Make sure QBCore is started before this resource
3. Change the dependency in fxmanifest.lua:
   dependencies {
       'qb-core'
   }
]]
