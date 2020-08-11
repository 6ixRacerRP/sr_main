fx_version 'bodacious'
game 'gta5'

client_script 'boot/cl_connections.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'config.lua',

    'boot/sv_connections.lua',
    'server/characters.lua'
} server_export 'GetSteamID'