require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Yubikey::OTP" do
  
  it "should parse a otp" do
    otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'
    key = 'ecde18dbe76fbd0c33330f1c354871db'
    
    token = Yubikey::OTP.new(otp, key)
    
    token.public_id.should == 'dteffuje'
    token.secret_id.should == '8792ebfe26cc'
    token.insert_counter.should == 19
    token.session_counter.should == 17
    token.timestamp.should == 49712
    token.random_number.should == 40904
  end
  
end
