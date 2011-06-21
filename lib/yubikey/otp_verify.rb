module Yubikey

  API_URL = 'https://api.yubico.com/wsapi/'
  API_ID  = 2549
  API_KEY = 'e928a7d3076516a8c8c879f42c3ea0388f3b19f'

  class OTP::Verify

    # The raw status from the Yubico server
    attr_reader :status

    def initialize(otp)
      verify("id=#{API_ID}&otp=#{otp}")
    end

    def valid?
      @status == 'OK'
    end

    def replayed?
      @status == 'REPLAYED_OTP'
    end

    private

    def verify(query)
      uri = URI.parse(API_URL) + 'verify'
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
    end
  end # OTP::Verify
end # Yubikey
