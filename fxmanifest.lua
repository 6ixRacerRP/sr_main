fx_version 'bodacious'
game 'gta5'

client_scripts {
    'boot/cl_connections.lua',
    
    'client/spawn/cl_spawnui.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'config.lua',

    'boot/sv_connections.lua',
    'server/characters.lua'
}

ui_page 'client/spawn/html/focus/nui.html'

files {
    'client/spawn/html/img/pp.png',
    'client/spawn/html/focus/nui.html',
    'client/spawn/html/focus/nui.css',
    'client/spawn/html/focus/script.js'
}