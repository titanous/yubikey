require 'mkmf'

dir_config('yubikey_ext')

have_header('yubikey.h')

create_makefile('yubikey_ext')
