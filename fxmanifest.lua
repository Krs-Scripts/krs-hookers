fx_version "cerulean"
game "gta5"
lua54 'yes'

name 'krs'
author 'Karos#7804'
description 'System'

shared_scripts {
    '@es_extended/imports.lua',
    "@ox_lib/init.lua",
    'shared/*.lua',
}

client_scripts {
    "client/*.lua"
}
server_scripts {
    "server/*.lua"
}

dependency {

    "ox_lib",
    "ox_inventory",
}