require 'rake'
require 'spec/rake/spectask'
require 'rdoc/task'

$LOAD_PATH.unshift('lib')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'yubikey'
    s.summary = 'A library to verify, decode, decrypt and parse Yubikey one-time passwords.'
    s.email = 'jon335@gmail.com'
    s.homepage = 'http://github.com/titanous/yubikey'
    s.description = 'A library to verify, decode, decrypt and parse Yubikey one-time passwords.'
    s.authors = ['Jonathan Rudenberg', 'James Cox']
    s.add_dependency 'crypt19'
    s.files = FileList['lib/*.rb', 'lib/**/*.rb', 'examples/*.rb', 'spec/*']
    s.rubyforge_project = 'yubikey'
    s.has_rdoc = true
    s.extra_rdoc_files = ['README.rdoc', 'LICENSE']
    s.rdoc_options << '--title' << 'yubikey' << '--main' << 'README.rdoc'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler'
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'yubikey'
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', 'spec/spec.opts']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec
