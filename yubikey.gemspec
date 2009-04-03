# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yubikey}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Rudenberg"]
  s.date = %q{2009-04-03}
  s.description = %q{A library to decode, decrypt and parse Yubikey one-time passwords.}
  s.email = %q{jon335@gmail.com}
  s.extensions = ["ext/yubikey_ext/extconf.rb"]
  s.extra_rdoc_files = ["ext/yubikey_ext/yubikey_ext.c", "README.rdoc", "LICENSE"]
  s.files = ["lib/yubikey.rb", "lib/yubikey/hex.rb", "lib/yubikey/otp.rb", "examples/otp.rb", "spec/hex_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/yubikey_ext_spec.rb", "spec/yubikey_otp_spec.rb", "ext/yubikey_ext/ykaes.c", "ext/yubikey_ext/ykcrc.c", "ext/yubikey_ext/ykmodhex.c", "ext/yubikey_ext/yubikey_ext.c", "ext/yubikey_ext/yubikey.h", "ext/yubikey_ext/extconf.rb", "README.rdoc", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/titanous/yubikey}
  s.rdoc_options = ["--title", "yubikey", "--main", "README.rdoc", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yubikey}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A library to decode, decrypt and parse Yubikey one-time passwords.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
