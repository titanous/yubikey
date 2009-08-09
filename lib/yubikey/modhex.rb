module Yubikey::ModHex
  
  TRANS = 'cbdefghijklnrtuv'.split(//)
  
  # Decode a ModHex string into binary data
  def self.decode(modhex_string)
    raise ArgumentError, "ModHex string length is not even" unless modhex_string.length % 2 == 0
    
    chars = 'cbdefghijklnrtuv'
    result = ""
    modhex_string.scan(/../).each do |c|
      result += (chars.index(c[0]) * 16 + chars.index(c[1])).chr
    end
    result
  end
  
  # Encode a binary string into ModHex
  def self.encode(string)
    result = ''
    
    string.each_byte do |b|
      result <<= TRANS[(b >> 4) & 0xF]
      result <<= TRANS[b & 0xF]
    end
    
    result
  end
  
end # Yubikey::ModHex