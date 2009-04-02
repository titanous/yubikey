class String
  
  def to_bin
    to_a.pack('H*')
  end
  
  def to_hex
    unpack('H*')[0]
  end
  
end