require File.dirname(__FILE__) + '/spec_helper'

$:.unshift File.dirname(__FILE__) + '/../ext/yubikey_ext'
require 'yubikey_ext.so'

describe 'yubikey_ext' do
  it 'should decode modhex' do
    ModHex.decode('hknhfjbrjnlnldnhcujvddbikngjrtgh').should == "i\266H\034\213\253\242\266\016\217\"\027\233X\315V"
    ModHex.decode('urtubjtnuihvntcreeeecvbregfjibtn').should == "\354\336\030\333\347o\275\f33\017\0345Hq\333"
    
    ModHex.decode('dteffuje').should == "-4N\203"
    
    ModHex.decode('ifhgieif').should == 'test'
    ModHex.decode('hhhvhvhdhbid').should == 'foobar'
  end
  
  it 'should raise if modhex string length uneven' do
    lambda { ModHex.decode('ifh') }.should raise_error(ArgumentError)
  end
  
  it 'should decrypt aes' do
    key = %w(72992427a3b8ccd20697493b5532561f).pack('H*')
    state = %w(ddf43aec57366784e061a12f767e728a).pack('H*')
    plain = %w(619dd70df3b30300de1bdb00ffbf6f26).pack('H*')
    
    AES.decrypt(state, key).should == plain
  end
  
  it 'should raise if aes key or state length is not 16' do
    lambda { AES.decrypt("i\266H\034\213\253\242\266\016\217\"\027\233X\315V", 'test') }.should raise_error(ArgumentError)
    lambda { AES.decrypt('test', "\354\336\030\333\347o\275\f33\017\0345Hq\333") }.should raise_error(ArgumentError)
  end
end