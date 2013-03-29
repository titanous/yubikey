describe Yubikey do
  after do
    Yubikey.reset
  end

  describe ".api_id" do
    it "should return the default api_id" do
      Yubikey.api_id.should == Yubikey::Configuration::DEFAULT_API_ID
    end
  end

  describe ".api_id=" do
    it "should set the api_id" do
      Yubikey.api_id = 8094
      Yubikey.api_id.should == 8094
    end
  end

  describe ".api_key" do
    it "should return the default api_key" do
      Yubikey.api_key.should == Yubikey::Configuration::DEFAULT_API_KEY
    end
  end

  describe ".api_key=" do
    it "should set the api_key" do
      Yubikey.api_key = 'NISwCZBQ0gTbuXbRGWAf4km5xXg='
      Yubikey.api_key.should == 'NISwCZBQ0gTbuXbRGWAf4km5xXg='
    end
  end

  describe ".configure" do

    Yubikey::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Yubikey.configure do |config|
          config.send("#{key}=", key)
          Yubikey.send(key).should == key
        end
      end
    end
  end
end