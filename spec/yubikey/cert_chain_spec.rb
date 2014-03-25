require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Cert Chain" do
  before do
    @cert_store = OpenSSL::X509::Store.new
    @cert_store.add_file Yubikey.certificate_chain
  end
  
  it "should accept cert from api.yubico.com" do
    uri = URI.parse('https://api.yubico.com/')

    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.cert_store = @cert_store
    
    req = Net::HTTP::Get.new(uri.request_uri)
    
    expect {http.request(req)}.to_not raise_error()
  end
  
  it "should not accept cert from anywhere else" do
    uri = URI.parse('https://www.google.com/')

    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http.cert_store = @cert_store
    
    req = Net::HTTP::Get.new(uri.request_uri)
    
    expect {http.request(req)}.to raise_error(OpenSSL::SSL::SSLError)
  end
end
