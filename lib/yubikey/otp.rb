class Yubikey::OTP
  attr_reader :public_id, :token, :aes_key, :secret_id, :insert_counter, :timestamp, :session_counter, :random_number
  
  def initialize(otp, key)    
    raise ArgumentError, 'OTP must be 32 to 64 characters of modhex' unless otp =~ /^[cbdefghijklnrtuv]{32,64}$/
    raise ArgumentError, 'Key must be 32 hex characters' unless key =~ /^[0-9a-fA-F]{32}$/
    
    @public_id = otp[0,otp.length-32] if otp.length > 32
    
    @token = Yubikey::ModHex.decode(otp[-32,32])
    @aes_key = key.to_bin
    
    decrypt
    parse
  end
  
  private
  
  def decrypt
    @token = Yubikey::AES.decrypt(@token, @aes_key)
  end
  
  def parse
    raise BadCRCError unless Yubikey::CRC.valid?(@token)
    
    @secret_id = @token[0,6].to_hex
    @insert_counter = @token[7] * 256 + @token[6]
    @timestamp = @token[10] * 65536 + @token[9] * 256 + @token[8]
    @session_counter = @token[11]
    @random_number = @token[13] * 256 + @token[12]
  end
  
  class BadCRCError < StandardError; end
end # Yubikey::OTP