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
    s.authors = ['Jonathan Rudenberg']
    s.add_dependency 'crypt'
    s.files = FileList['lib/*.rb', 'lib/**/*.rb', 'examples/*.rb', 'spec/*']
    s.rubyforge_project = 'yubikey'
    s.has_rdoc = true
    s.extra_rdoc_files = ['README.rdoc', 'LICENSE']
    s.rdoc_options << '--title' << 'yubikey' << '--main' << 'README.rdoc'
  end
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com'
end

begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc 'Release gem and RDoc documentation to RubyForge'
    task :release => ['rubyforge:release:gem', 'rubyforge:release:docs']

    namespace :release do
      desc 'Publish RDoc to RubyForge.'
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = '/var/www/gforge-projects/yubikey/'
        local_dir = 'doc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts 'Rake SshDirPublisher is unavailable or your rubyforge environment is not configured.'
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