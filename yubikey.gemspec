# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yubikey}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Rudenberg"]
  s.date = %q{2009-04-21}
  s.description = %q{A library to decode, decrypt and parse Yubikey one-time passwords.}
  s.email = %q{jon335@gmail.com}
  s.extensions = ["ext/yubikey_ext/extconf.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "ext/yubikey_ext/yubikey_ext.c"
  ]
  s.files = [
    "examples/otp.rb",
    "ext/yubikey_ext/extconf.rb",
    "ext/yubikey_ext/ykaes.c",
    "ext/yubikey_ext/ykcrc.c",
    "ext/yubikey_ext/yubikey.h",
    "ext/yubikey_ext/yubikey_ext.c",
    "lib/yubikey.rb",
    "lib/yubikey.rb",
    "lib/yubikey/hex.rb",
    "lib/yubikey/modhex.rb",
    "lib/yubikey/otp.rb",
    "spec/hex_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/yubikey_ext_spec.rb",
    "spec/yubikey_modhex_spec.rb",
    "spec/yubikey_otp_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/titanous/yubikey}
  s.rdoc_options = ["--charset=UTF-8", "--title", "yubikey", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{yubikey}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A library to decode, decrypt and parse Yubikey one-time passwords.}
  s.test_files = [
    "spec/hex_spec.rb",
    "spec/spec_helper.rb",
    "spec/yubikey_ext_spec.rb",
    "spec/yubikey_modhex_spec.rb",
    "spec/yubikey_otp_spec.rb",
    "examples/otp.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
