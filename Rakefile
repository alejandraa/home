#!/usr/bin/env rake
#
# This is for Rake tasks that pertain to the development and
# maintainence of DOTS itself. All tasks that can be loaded
# with `rake -g` should be put into a .rake file in ~/.dots/lib/tasks.
#
# These tasks are also available within DOTS natively.

require 'rake'
require 'bundler/gem_tasks'

Dir["lib/tasks/*.rake"].each { |rake_file| load rake_file }

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError => e
  # RSpec can not be run in the gem installation.
end

desc "Update DOTS, Antigen, and all installed plugins."
task :update do
  sh "cd ~/.dots && git pull origin master"
  sh "cd ~/.dots && git submodule sync"
  sh "antigen-update"
end
