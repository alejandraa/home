#
# Default Rails application template
#

gem 'haml'
gem 'puma'

gem_group :development do
  gem 'haml-rails'
  gem 'ruby_parser'
  gem 'hpricot'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'capybara'
end

initializer "generators.rb", <<-RUBY
Rails.application.config.generators do |g|
  g.template_engine :haml
  g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
end
RUBY

rakefile "base.rake" do
  <<-RUBY
    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new :spec

    task :test => ['db:test:prepare', 'spec']

    task :server do
      sh "rails server puma"
    end
  RUBY
end

file ".env" do
  <<-RUBY
    export GEM_HOME='vendor/gems'
  RUBY
end

file "README.md" do
  <<-MARKDOWN
    # #{app_name.titleize}

    A thorough description of the application.
  MARKDOWN
end

run "createuser -s #{app_name}"
run "bundle install"
run "bundle exec rails generate rspec:install"
rake 'db:create'
rake 'db:test:prepare'
run "rm -rf test/; rm -rf README.rdoc; rm -rf public/index.html"
run "git init && git add . && git commit -am 'Initial commit.'"
