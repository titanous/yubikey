require 'yubikey'

begin

  Yubikey.configure do |config|
    config.api_id = 'YOUR_API_ID'
    config.api_key = 'YOUR_API_KEY'
  end

  otp = 'THE_OTP_TO_TEST'

  token = Yubikey::OTP::Verify::new(:otp => otp)

  if token.valid?
    p 'valid OTP'
  elsif token.replayed?
    p 'replayed OTP'
  else
    p token.status
  end
rescue Yubikey::OTP::InvalidOTPError
  p 'invalid OTP'
end