# yubikey

[![Build Status](https://travis-ci.org/titanous/yubikey.png?branch=master)](https://travis-ci.org/titanous/yubikey)

## Description

A library to verify, decode, decrypt and parse [Yubikey](http://www.yubico.com/home/index/) one-time passwords.

## Usage

### OTP Decryption

```ruby
key = 'ecde18dbe76fbd0c33330f1c354871db'
otp = 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh'
token = Yubikey::OTP.new(otp, key)

p "Device public id: #{token.public_id}" #=> 'dteffuje'
p "Device secret id: #{token.secret_id}" #=> '8792ebfe26cc'
p "Device insertions: #{token.insert_counter}" #=> 19
p "Session activation counter: #{token.session_counter}" #=> 17
p "Session timestamp: #{token.timestamp}" #=> 49712
p "OTP random data: #{token.random_number}" #=> 40904
```

### OTP Verification
Use your own `api_key` and `api_id`, which you can get at [yubico.com](https://upgrade.yubico.com/getapikey/).

```ruby
begin
  otp = Yubikey::OTP::Verify.new(:api_id => 1234,
                                 :api_key => 'NiSwGZBQ0gTbwXbRGWAf4kM5xXg=',
                                 :otp => 'dteffujehknhfjbrjnlnldnhcujvddbikngjrtgh')

  if otp.valid?
    p 'valid OTP'
  elsif otp.replayed?
    p 'replayed OTP'
  end
rescue Yubikey::OTP::InvalidOTPError
  p 'invalid OTP'
end
```

## Install

Yubikey is available as a gem, to install it just install the gem:

    gem install yubikey

If you're using Bundler, add the gem to Gemfile.

    gem 'yubikey'

Then run bundle install.

## Copyright

### Ruby library

Written by [Jonathan Rudenberg](https://github.com/titanous). Copyright (c) 2009 Jonathan Rudenberg

The MIT License. See [LICENSE](https://github.com/titanous/yubikey/blob/master/LICENSE).

### Contributors

[List of contributors](https://github.com/titanous/yubikey/graphs/contributors)