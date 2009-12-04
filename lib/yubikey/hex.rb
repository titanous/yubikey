class String
  
  # Convert hex string to binary
  def to_bin
    [self].pack('H*')
  end
  
  # Convert binary string to hex
  def to_hex
    unpack('H*')[0]
  end
  
  # Check if the string is hex encoded
  def hex?
    self =~ /^[0-9a-fA-F]+$/ ? true : false
  end
  
  # Check if the string is modhex encoded
  def modhex?
    self =~ /^[cbdefghijklnrtuv]+$/ ? true : false
  end
  
end