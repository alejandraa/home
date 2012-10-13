#!/usr/bin/env rake
require 'rake'
require 'rspec/core/rake_task'

# Global Rake tasks, available anywhere by running `rake -g`
Dir["lib/tasks/*.rake"].each { |rake_file| load rake_file }

# Test task for the local testing suite
RSpec::Core::RakeTask.new(:test)
