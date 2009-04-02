class String
  
  def to_bin
    to_a.pack('H*')
  end
  
  def to_hex
    unpack('H*')[0]
  end
  
  def hex?
    self =~ /^[0-9a-fA-F]+$/ ? true : false
  end
  
  def modhex?
    self =~ /^[cbdefghijklnrtuv]+$/ ? true : false
  end
end