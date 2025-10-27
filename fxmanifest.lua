fx_version 'cerulean'
game 'gta5'

author 'HesamDev'
description 'Professional Reputation System for FiveM'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'server/database.lua',
    'server/trustfactor.lua',
    'server/admin.lua',
    'server/main.lua',
    'server_commands.lua'
}

files {
    'reputation.sql'
}

client_scripts {
    'client/*.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'

lua54 'yes'
