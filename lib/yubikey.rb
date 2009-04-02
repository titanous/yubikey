$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'yubikey_ext'
require 'yubikey/hex'
require 'yubikey/otp'

module Yubikey
  VERSION = '0.2.0'
end