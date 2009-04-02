require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'yubikey'))

key = 'ecde18dbe76fbd0c33330f1c354871db'
otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'
token = Yubikey::OTP.new(otp, key)

p "Device public id: #{token.public_id}"
p "Device secret id: #{token.secret_id}"
p "Device insertions: #{token.insert_counter}"
p "Session activation counter: #{token.session_counter}"
p "Session timestamp: #{token.timestamp}"
p "OTP random data: #{token.random_number}"