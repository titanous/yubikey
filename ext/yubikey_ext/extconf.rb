require 'mkmf'

dir_config('yubikey_ext', '/usr/local')

have_header('yubikey.h')
have_library('yubikey', 'yubikey_modhex_encode', 'yubikey.h')

create_makefile('yubikey_ext')