#!/usr/bin/env rake

require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError => e
  # RSpec can not be run in the gem installation.
end

Dir["lib/tasks/*.rake"].each { |rake_file| load rake_file }

desc "Preload some config files to bootstrap the framework"
task :default => ['install:configuration', 'install:submodules']
