require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'Yubikey::Modhex' do
  it 'should decode modhex' do
    Yubikey::ModHex.decode('hknhfjbrjnlnldnhcujvddbikngjrtgh').should == "i\266H\034\213\253\242\266\016\217\"\027\233X\315V"
    Yubikey::ModHex.decode('urtubjtnuihvntcreeeecvbregfjibtn').should == "\354\336\030\333\347o\275\f33\017\0345Hq\333"
    
    Yubikey::ModHex.decode('dteffuje').should == "-4N\203"
    
    Yubikey::ModHex.decode('ifhgieif').should == 'test'
    Yubikey::ModHex.decode('hhhvhvhdhbid').should == 'foobar'
    
    Yubikey::ModHex.decode('cc').should == "\000"
  end
  
  it 'should raise if modhex string length uneven' do
    lambda { Yubikey::ModHex.decode('ifh') }.should raise_error(ArgumentError)
  end
  
  it 'should encode modhex' do
    Yubikey::ModHex.encode("i\266H\034\213\253\242\266\016\217\"\027\233X\315V").should == 'hknhfjbrjnlnldnhcujvddbikngjrtgh'
    Yubikey::ModHex.encode("\354\336\030\333\347o\275\f33\017\0345Hq\333").should == 'urtubjtnuihvntcreeeecvbregfjibtn'
    
    Yubikey::ModHex.encode("-4N\203").should == 'dteffuje'
    
    Yubikey::ModHex.encode('test').should == 'ifhgieif'
    Yubikey::ModHex.encode('foobar').should == 'hhhvhvhdhbid'
    
    Yubikey::ModHex.encode("\000").should == 'cc'
  end
end