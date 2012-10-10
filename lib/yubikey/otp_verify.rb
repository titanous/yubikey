require 'base64'
require 'hmac-sha1'
require 'SecureRandom'

module Yubikey
  
  API_URL = 'https://api.yubico.com/wsapi/2.0/'

  class OTP::Verify
    # The raw status from the Yubico server
    attr_reader :status

    def initialize(args)
      raise(ArgumentError, "Must supply API ID") if args[:api_id].nil?
      raise(ArgumentError, "Must supply API Key") if args[:api_key].nil?
      raise(ArgumentError, "Must supply OTP") if args[:otp].nil?

      @api_key = args[:api_key]
      @api_id = args[:api_id]
      
      @url = args[:url] || API_URL
      @nonce = args[:nonce] || generate_nonce(32)

      verify(args)
    end
    
    def valid?
      @status == 'OK'
    end
    
    def replayed?
      @status == 'REPLAYED_OTP'
    end
    
    private
    
    def verify(args)

      query = "id=#{@api_id}&otp=#{args[:otp]}&nonce=#{@nonce}"

      uri = URI.parse(@url) + 'verify'
      uri.query = query
      
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
      return SecureRandom.hex length/2
    end

    def verify_response(result)

      signature = result[/^h=(.+)$/, 1].strip
      returned_nonce = result[/nonce=(.+)$/, 1]
      returned_nonce.strip! unless returned_nonce.nil?

      if @nonce != returned_nonce
        return false
      end

      generated_signature = self.class.generate_hmac(result, @api_key)

      return signature == generated_signature
    end

    def self.generate_hmac(response, api_key)
      response_params = response.split(' ')
      response_params.reject! do |p|
        p =~ /^h=(.+)$/
      end

      response_string = response_params.sort.join('&')
      response_string.strip!
      response_string.encode! 'UTF-8'

      hmac = HMAC::SHA1.new(Base64.decode64(api_key))
      hmac.update(response_string)

      return Base64.encode64(hmac.digest).strip
    end
  end # OTP::Verify
end # Yubikey
