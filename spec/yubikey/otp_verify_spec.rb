describe 'Yubikey::OTP::Verify' do

  before do
    @otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'

    @mock_http = mock('http')
    @mock_http_get = mock('http_get')

    Net::HTTP.should_receive(:new).with('api.yubico.com', 443).and_return(@mock_http)
    @mock_http.should_receive(:use_ssl=).and_return(nil)
    @mock_http.should_receive(:verify_mode=).and_return(nil)
    @mock_http.should_receive(:request).with(@mock_http_get).and_return(@mock_http_get)
    Net::HTTP::Get.should_receive(:new).with(/otp=#{@otp}/).and_return(@mock_http_get)
  end


  context "Verifies a valid OTP" do

    before :each do
      @mock_http_get.should_receive(:body).and_return('status=OK')
      @result = Yubikey::OTP::Verify.new(@otp)
    end

    it "is valid" do
      @result.valid?.should be_true
    end

    it "is not replayed" do
      @result.replayed?.should be_false
    end

  end


  context "Verifies a replayed OTP" do

    before :each do
      @mock_http_get.should_receive(:body).and_return('status=REPLAYED_OTP')
      @result = Yubikey::OTP::Verify.new(@otp)
    end

    it "is invalid" do
      @result.valid?.should be_false
    end

    it "is replayed" do
      @result.replayed?.should be_true
    end

  end

  it "raises an invalid OTP error" do
    @mock_http_get.should_receive(:body).and_return('status=BAD_OTP')
    expect { Yubikey::OTP::Verify.new(@otp) }.to raise_error(Yubikey::OTP::InvalidOTPError)
  end


end