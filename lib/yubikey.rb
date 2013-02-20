$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'net/https'
require 'crypt/rijndael'
require 'openssl'

module Yubikey; end;

require 'yubikey/hex'
require 'yubikey/modhex'
require 'yubikey/otp'
require 'yubikey/otp_verify'