require 'base64'
require 'hmac-sha1'

module Yubikey
  
  API_URL = 'https://api.yubico.com/wsapi/2.0/'

  class OTP::Verify
    # The raw status from the Yubico server
    attr_reader :status

    @id  = ''
    @key = ''
    @http

    def initialize(args)
      raise(ArgumentError, "Must supply API ID") if args[:id].nil?
      raise(ArgumentError, "Must supply API Key") if args[:key].nil?
      raise(ArgumentError, "Must supply OTP") if args[:otp].nil?

      @key = args[:key]
      @id = args[:id]
      
      @url = args[:url] || API_URL
      @nonce = args[:nonce] || generate_nonce(32)

      verify("id=#{@id}&otp=#{args[:otp]}")
    end
    
    def valid?
      @status == 'OK'
    end
    
    def replayed?
      @status == 'REPLAYED_OTP'
    end
    
    private
    
    def verify(query)

      uri = URI.parse(@url) + 'verify'
      uri.query = query + "&nonce=#{@nonce}"
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      req = Net::HTTP::Get.new(uri.request_uri)
      result = http.request(req).body

      @status = result[/status=(.*)$/,1].strip
      
      if @status == 'BAD_OTP' || @status == 'BACKEND_ERROR'
        raise OTP::InvalidOTPError, "Received error: #{@status}"
      end

      if ! verify_response(result)
        @status = 'BAD_RESPONSE'
        return
      end
    end

    def generate_nonce(length)
      characters = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      nonce = ''
      1.upto(length) { |index| nonce << characters[rand(characters.size-1)] }

      return nonce
    end

    def verify_response(result)
      signature = result[/^h=(.+)$/, 1].strip
      returned_nonce = result[/nonce=(.+)$/, 1]
      returned_nonce.strip! unless returned_nonce.nil?

      if @nonce != returned_nonce
        return false
      end

      generated_signature = self.class.generate_hmac(result, @key)

      return signature == generated_signature
    end

    def self.generate_hmac(response, key)
      response_params = response.split(' ')
      response_params.reject! do |p|
        p =~ /^h=(.+)$/
      end

      response_string = response_params.sort.join('&')
      response_string.strip!
      response_string.encode! 'UTF-8'

      hmac = HMAC::SHA1.new(Base64.decode64(key))
      hmac.update(response_string)

      return Base64.encode64(hmac.digest).strip
    end
  end # OTP::Verify
end # Yubikey
