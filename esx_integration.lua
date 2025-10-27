-- ESX Integration (Optional)
-- Uncomment and modify if using ESX

--[[
local ESX = nil

-- Initialize ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Get player group from ESX
function Admin:GetPlayerGroup(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        return xPlayer.group
    end
    return 'user'
end

-- Update get identifier for ESX
function Database:GetIdentifier(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        return xPlayer.identifier
    end
    return false
end
]]

--[[ 
To use with ESX:
1. Uncomment the code above
2. Make sure ESX is started before this resource
3. Change the dependency in fxmanifest.lua:
   dependencies {
       'es_extended'
   }
]]
