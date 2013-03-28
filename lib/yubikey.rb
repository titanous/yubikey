$LOAD_PATH.unshift(File.dirname(__FILE__)) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/https'
require 'openssl'

require 'yubikey/configuration'
require 'yubikey/hex'
require 'yubikey/modhex'
require 'yubikey/otp'
require 'yubikey/otp_verify'

module Yubikey
  extend Configuration
end

