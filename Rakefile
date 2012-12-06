#!/usr/bin/env rake


begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError => e
  # RSpec can not be run in the gem installation.
end

require 'bundler/gem_tasks'

Dir["lib/tasks/*.rake"].each { |rake_file| load rake_file }

desc "Update DOTS, Antigen, and all installed plugins."
task :update do
  sh "cd ~/.dots && git pull origin master"
  sh "cd ~/.dots && git submodule sync"
  sh "antigen-update"
end
