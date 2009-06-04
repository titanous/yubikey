$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/http'
require 'openssl'

require 'yubikey_ext'
require 'yubikey/hex'
require 'yubikey/modhex'
require 'yubikey/otp'
require 'yubikey/otp_verify'