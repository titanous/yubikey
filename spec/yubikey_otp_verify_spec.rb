require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Yubikey::OTP::Verify' do

  before do
    @otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'

    @mock_http = mock('http')
    @mock_http_get = mock('http_get')

    Net::HTTP.should_receive(:new).with('api.yubico.com', 443).and_return(@mock_http)
    @mock_http.should_receive(:use_ssl=).and_return(nil)
    @mock_http.should_receive(:verify_mode=).and_return(nil)
    @mock_http.should_receive(:ca_file=).and_return(nil)
    @mock_http.should_receive(:request).with(@mock_http_get).and_return(@mock_http_get)
    Net::HTTP::Get.should_receive(:new).with(/otp=#{@otp}/).and_return(@mock_http_get)
  end

  it 'should verify a valid OTP' do
    @mock_http_get.should_receive(:body).and_return('status=OK')
    otp = Yubikey::OTP::Verify.new(@otp)
    otp.valid?.should == true
    otp.replayed?.should == false
  end

  it 'should verify a replayed OTP' do
    @mock_http_get.should_receive(:body).and_return('status=REPLAYED_OTP')
    otp = Yubikey::OTP::Verify.new(@otp)
    otp.valid?.should == false
    otp.replayed?.should == true
  end

  it 'should raise on invalid OTP' do
    @mock_http_get.should_receive(:body).and_return('status=BAD_OTP')
    lambda { otp = Yubikey::OTP::Verify.new(@otp) }.should raise_error(Yubikey::OTP::InvalidOTPError)
  end


end
