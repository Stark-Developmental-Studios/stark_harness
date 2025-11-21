fx_version 'cerulean'

use_experimental_fxv2_oal 'yes'

lua54 'yes'

game 'gta5'

name 'stark_harness'

author 'Adama Stark'

version '4.0.0'

repository 'https://github.com/AdamaStark-N7/stark_harness'

description 'A Vehicle Harness Resource For FiveM'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
}

client_script {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}

files {
    'shared/config.lua',
    'locales/*.json',
}

dependencies {
    'oxmysql',
    'ox_lib'
}
