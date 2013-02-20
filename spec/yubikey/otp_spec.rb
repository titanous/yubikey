describe 'Yubikey::OTP' do

  describe "should parse an OTP" do

    before :all do
      @token = Yubikey::OTP.new('enrlucvketdlfeknvrdggingjvrggeffenhevendbvgd', '4013a2c719c4e9734bbc63048b00e16b')
    end

    it "has the expected public_id" do
      @token.public_id.should == 'enrlucvketdl'
    end

    it "has the expected secret_id" do
      @token.secret_id.should == '912a644bbc7b'
    end

    it "has the expected insert_counter" do
      @token.insert_counter.should == 1
    end

    it "has the expected session_counter" do
      @token.session_counter.should == 0
    end

    it "has the expected timestamp" do
      @token.timestamp.should == 688051
    end

    it "has the expected random_number" do
      @token.random_number.should == 55936
    end

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
