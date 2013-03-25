require 'yubikey'

begin
  api_id = 'YOUR_API_ID'
  api_key = 'YOUR_API_KEY'
  otp = 'THE_OTP_TO_TEST'
  
  token = Yubikey::OTP::Verify::new(:api_id => api_id, :api_key => api_key, :otp => otp)

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