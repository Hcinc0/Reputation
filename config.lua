Config = {}

-- Tanzimat-e Koli
Config.Locale = 'fa'
Config.EnableNotifications = true
Config.EnableUI = true

-- Tanzimat-e Trust Factor
Config.DefaultTrustFactor = 500
Config.MaxTrustFactor = 1000
Config.MinTrustFactor = 0
Config.BanThreshold = 50  -- Vaghti Trust Factor be in meghdar beresad player ban mishavad

-- Satlbndi Trust Factor (mesl CS:GO)
Config.TrustFactorLevels = {
    {min = 950, max = 1000, name = 'Expert', color = '#FFD700'},
    {min = 850, max = 949, name = 'Master', color = '#FF6347'},
    {min = 700, max = 849, name = 'Legendary', color = '#9370DB'},
    {min = 600, max = 699, name = 'Elite', color = '#00CED1'},
    {min = 500, max = 599, name = 'Veteran', color = '#32CD32'},
    {min = 400, max = 499, name = 'Experienced', color = '#98FB98'},
    {min = 300, max = 399, name = 'Competent', color = '#87CEEB'},
    {min = 200, max = 299, name = 'Novice', color = '#D3D3D3'},
    {min = 100, max = 199, name = 'Beginner', color = '#FFA07A'},
    {min = 0, max = 99, name = 'Suspicious', color = '#FF0000'}
}

-- Tanzimat-e Penalty
Config.PenaltyReasons = {
    RDM = -30,
    VDM = -40,
    METAGAMING = -20,
    POWERGAMING = -25,
    FAILRP = -35,
    NVL = -20,
    COMBATLOGGING = -30,
    CHEATING = -100
}

Config.PenaltyBonuses = {
    HELPING = 10,
    GOODBEHAVIOR = 5,
    REPORTER = 15
}

-- Tanzimat-e Admin
Config.AdminGroups = {
    'admin',
    'god',
    'superadmin',
    'moderator',
    'support'
}

Config.EnableAutoBan = true
Config.LogToFile = true
Config.LogFilePath = 'logs/trustfactor.txt'

-- Tanzimat-e UI
Config.UIPosition = 'top-right'
Config.UIShowLevel = true
Config.UIShowProgress = true
Config.UIRefreshRate = 1000  -- Mili Saniye
