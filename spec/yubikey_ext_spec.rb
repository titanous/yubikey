require File.dirname(__FILE__) + '/spec_helper'

$:.unshift File.dirname(__FILE__) + '/../ext/yubikey_ext'
require 'yubikey_ext.so'

describe 'yubikey_ext' do
  it 'should decrypt aes' do
    key = '72992427a3b8ccd20697493b5532561f'.to_bin
    state = 'ddf43aec57366784e061a12f767e728a'.to_bin
    plain = '619dd70df3b30300de1bdb00ffbf6f26'.to_bin
    
    Yubikey::AES.decrypt(state, key).should == plain
  end
  
  it 'should raise if aes key or state length is not 16' do
    lambda { Yubikey::AES.decrypt("i\266H\034\213\253\242\266\016\217\"\027\233X\315V", 'test') }.
      should raise_error(ArgumentError)
    
    lambda { Yubikey::AES.decrypt('test', "\354\336\030\333\347o\275\f33\017\0345Hq\333") }.
      should raise_error(ArgumentError)
  end
  
  it 'should check a crc' do
    Yubikey::CRC.valid?('619dd70df3b30300de1bdb00ffbf6f26'.to_bin).should == true
    Yubikey::CRC.valid?('ddf43aec57366784e061a12f767e728a'.to_bin).should == false
  end
  
  it 'should raise if crc token length not 16' do
    lambda { Yubikey::CRC.valid?('619dd70df3b30300de1bdb00ffbf6f'.to_bin) }.
      should raise_error(ArgumentError)
  end
end