require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Yubikey::OTP' do
  it 'should parse a otp' do
    token = Yubikey::OTP.new('dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh', 'ecde18dbe76fbd0c33330f1c354871db')
    
    token.public_id.should == 'dteffuje'
    token.secret_id.should == '8792ebfe26cc'
    token.insert_counter.should == 19
    token.session_counter.should == 17
    token.timestamp.should == 49712
    token.random_number.should == 40904
  end
  
  it 'should raise if key or otp invalid' do
    otp = 'hknhfjbrjnlnldnhcujvddbikngjrtgh'
    key = 'ecde18dbe76fbd0c33330f1c354871db'
    
    lambda { Yubikey::OTP.new(key, key) }.should raise_error(Yubikey::OTP::InvalidOTPError)
    lambda { Yubikey::OTP.new(otp, otp) }.should raise_error(Yubikey::OTP::InvalidKeyError)
    
    lambda { Yubikey::OTP.new(otp[0,31], key) }.should raise_error(Yubikey::OTP::InvalidOTPError)
    lambda { Yubikey::OTP.new(otp, key[0,31]) }.should raise_error(Yubikey::OTP::InvalidKeyError)
    
    lambda { Yubikey::OTP.new(otp[1,31]+'d', key) }.should raise_error(Yubikey::OTP::BadCRCError)
  end
  
end
