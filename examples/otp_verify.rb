require 'yubikey'
require 'net-http-spy'

key = 'ecde18dbe76fbd0c33330f1c354871db'
otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'
token = Yubikey::OTP.new(otp, key)

p "Device public id: #{token.public_id}"
p "Device secret id: #{token.secret_id}"
p "Device insertions: #{token.insert_counter}"
p "Session activation counter: #{token.session_counter}"
p "Session timestamp: #{token.timestamp}"
p "OTP random data: #{token.random_number}"

puts "VERIFICATION"

p Yubikey::OTP::Verify.new(otp)

