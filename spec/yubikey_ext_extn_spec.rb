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
  
  it 'should decrypt aes' do
    pending
  end
end