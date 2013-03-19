class Yubikey::OTP
  # first few modhex encoded characters of the OTP
  attr_reader :public_id
  # decrypted binary token
  attr_reader :token
  # binary AES key
  attr_reader :aes_key
  # hex id (encrypted in OTP)
  attr_reader :secret_id
  # integer that increments each time the Yubikey is plugged in
  attr_reader :insert_counter
  # ~8hz timer, reset on every insert
  attr_reader :timestamp
  # activation counter, reset on every insert
  attr_reader :session_counter
  # random integer used as padding and extra random noise
  attr_reader :random_number


  # Decode/decrypt a Yubikey one-time password
  #
  # [+otp+] ModHex encoded Yubikey OTP (at least 32 characters)
  # [+key+] 32-character hex AES key
  def initialize(otp, key)

    # Get the public ID first
    @public_id = otp[0, 12]

    # Strip prefix so otp will decode (following from yubico-c library)
    otp = otp[-32,32] if otp.length > 32

    raise InvalidOTPError, 'OTP must be at least 32 characters of modhex' unless otp.modhex? && otp.length >= 32
    raise InvalidKeyError, 'Key must be 32 hex characters' unless key.hex? && key.length == 32


    @token = Yubikey::ModHex.decode(otp[-32,32])
    @aes_key = key.to_bin

    decrypter = OpenSSL::Cipher.new('AES-128-ECB').decrypt
    decrypter.key = @aes_key
    decrypter.padding = 0

    @token = decrypter.update(@token) + decrypter.final

    raise BadCRCError unless crc_valid?

    @secret_id, @insert_counter, @timestamp, @timestamp_lo, @session_counter, @random_number, @crc = @token.unpack('H12vvCCvv')
    @timestamp += @timestamp_lo * 65536
  end

  private

  def crc_valid?
    crc = 0xffff
    @token.each_byte do |b|
      crc ^= b & 0xff
      8.times do
        test = (crc & 1) == 1
        crc >>= 1
        crc ^= 0x8408 if test
      end
    end
    crc == 0xf0b8
  end

  # :stopdoc:
  class InvalidOTPError < StandardError; end
  class InvalidKeyError < StandardError; end
  class BadCRCError < StandardError; end
end # Yubikey::OTP
