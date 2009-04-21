module Yubikey::ModHex
  
  TRANS = 'cbdefghijklnrtuv'.split(//)
  
  # Decode a ModHex string into binary data
  def self.decode(modhex_string)
    out = ''
    flag = true  # to switch between first and last nibble
    byte = 0
    
    raise ArgumentError, "ModHex string length is not even" unless modhex_string.length % 2 == 0
    
    modhex_string.each_byte do |b|
      x = TRANS.index(b.chr)  # lookup occurrence in table
      if flag
        byte = x
      else
        byte = (byte << 4) | x
        out <<= byte.chr 
      end
      flag = !flag
    end
    
    out
  end
  
  # Encode a binary string into ModHex
  def self.encode(string)
    out = ''
    
    string.each_byte do |b|
      out <<= TRANS[(b >> 4) & 0xF]
      out <<= TRANS[b & 0xF]
    end
    
    out
  end
  
end # Yubikey::ModHex