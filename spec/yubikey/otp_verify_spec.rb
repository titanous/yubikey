require File.dirname(__FILE__) + '/../spec_helper.rb'

describe 'Yubikey::OTP::Verify' do
  
  before do
    @otp = 'ccccccbfueddkcnctfkrhdfrbtfutgtididiguttlctr'
    @id  = 8094
    @key = 'NISwCZBQ0gTbuXbRGWAf4km5xXg='
    @nonce = 'cEnCRWOnpFurshnksfcAEZvWoqdXlwbs'
    @response = "t=2012-08-01T16:09:08Z0899\n" +
      "otp=ccccccbfueddkcnctfkrhdfrbtfutgtididiguttlctr\n" +
      "nonce=cEnCRWOnpFurshnksfcAEZvWoqdXlwbs\n"
    
    @mock_http = mock('http')
    @mock_http_get = mock('http_get')
    
    Net::HTTP.stub!(:new).with('api.yubico.com', 443).and_return(@mock_http)
    @mock_http.stub!(:use_ssl=).and_return(nil)
    @mock_http.stub!(:verify_mode=).and_return(nil)
    @mock_http.stub!(:request).with(@mock_http_get).and_return(@mock_http_get)
    Net::HTTP::Get.stub!(:new).with(/id=#{@id}&otp=#{@otp}&nonce=[a-zA-Z0-9]{32}/).and_return(@mock_http_get)
  end
  
  it 'should verify a valid OTP' do
    ok_response = "#{@response}status=OK"
    hmac = Yubikey::OTP::Verify::generate_hmac(ok_response, @key)
    @mock_http_get.should_receive(:body).and_return("h=#{hmac}\n#{ok_response}")
    otp = Yubikey::OTP::Verify.new(:api_id => @id, :api_key => @key, :otp => @otp, :nonce => @nonce)
    otp.valid?.should == true
    otp.replayed?.should == false
  end
  
  it 'should verify a replayed OTP' do
    replayed_response = "#{@response}status=REPLAYED_OTP"
    hmac = Yubikey::OTP::Verify::generate_hmac(replayed_response, @key)
    @mock_http_get.should_receive(:body).and_return("h=#{hmac}\n#{replayed_response}")
    otp = Yubikey::OTP::Verify.new(:api_id => @id, :api_key => @key, :otp => @otp, :nonce => @nonce)
    otp.valid?.should == false
    otp.replayed?.should == true
  end
  
  it 'should raise on invalid OTP' do
    bad_response = "#{@response}status=BAD_OTP"
    hmac = Yubikey::OTP::Verify::generate_hmac(bad_response, @key)
    @mock_http_get.should_receive(:body).and_return("h=#{hmac}\n#{bad_response}")
    lambda { otp = Yubikey::OTP::Verify.new(:api_id => @id, :api_key => @key, :otp => @otp, :nonce => @nonce) }.should raise_error(Yubikey::OTP::InvalidOTPError)
  end

  it 'should generate a correct hmac' do
    Yubikey::OTP::Verify::generate_hmac(@response, @key).should == 'sZqbbsXL5WIdqLNmr19/eq6acSM='
  end

end
