begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError => e
  # RSpec can not be run in the gem installation.
end

