Database = {}

-- Initialize SQLite Database
function Database:Initialize()
    -- Create table for storing player trust factor
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS reputation_data (
            identifier VARCHAR(100) PRIMARY KEY,
            trust_factor INT DEFAULT 500,
            level_name VARCHAR(50),
            last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]], {}, function(affectedRows)
        if affectedRows then
            print('^2[Reputation]^7 Table created successfully')
        end
    end)
end

-- Get player identifier
function Database:GetIdentifier(src)
    local identifiers = GetPlayerIdentifiers(src)
    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 5) == 'steam' then
            return identifier
        elseif string.sub(identifier, 1, 7) == 'license' then
            return identifier
        end
    end
    return false
end

-- Create new player
function Database:CreatePlayer(src, defaultTrust)
    local identifier = self:GetIdentifier(src)
    if not identifier then
        print('^1[Reputation]^7 Could not get identifier for source: ' .. src)
        return false
    end
    
    MySQL.insert('INSERT INTO reputation_data (identifier, trust_factor) VALUES (?, ?) ON DUPLICATE KEY UPDATE identifier = identifier', {
        identifier,
        defaultTrust
    }, function(insertId)
        if insertId then
            return true
        end
    end)
    
    return true
end

-- Get player data
function Database:GetPlayerData(src, callback)
    local identifier = self:GetIdentifier(src)
    if not identifier then
        callback(nil)
        return
    end
    
    MySQL.query('SELECT * FROM reputation_data WHERE identifier = ?', {
        identifier
    }, function(result)
        if result and #result > 0 then
            callback(result[1])
        else
            callback(nil)
        end
    end)
end

-- Update trust factor
function Database:UpdateTrustFactor(src, newTrust)
    local identifier = self:GetIdentifier(src)
    if not identifier then return false end
    
    MySQL.update('UPDATE reputation_data SET trust_factor = ?, last_update = CURRENT_TIMESTAMP WHERE identifier = ?', {
        newTrust,
        identifier
    })
    
    return true
end

-- Get all players data
function Database:GetAllPlayersData(callback)
    MySQL.query('SELECT * FROM reputation_data ORDER BY trust_factor DESC', {}, function(result)
        if result then
            callback(result)
        else
            callback({})
        end
    end)
end
