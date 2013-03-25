require 'rake'
require 'rspec/core/rake_task'
require 'rdoc/task'

$LOAD_PATH.unshift('lib')

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'yubikey'
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--options', 'spec/spec.opts']
end

task :default => :spec