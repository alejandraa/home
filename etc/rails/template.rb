#
# Default Rails application template
#

gem 'haml'

gem_group :development do
  gem 'haml-rails'
  gem 'ruby_parser'
  gem 'hpricot'
  gem 'puma'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'capybara'
end

# Template files
initializer "generators.rb", <<-RUBY
Rails.application.config.generators do |g|
  g.template_engine :haml
  g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
end
RUBY

rakefile "base.rake" do
  <<-RUBY
task :server do
  sh "rails server puma"
end
  RUBY
end

%w(.env .travis.yml).each do |name|
  file(name) { IO.read File.expand_path("~/etc/rails/template/#{name}") }
end

file("README.md") { "# #{app_name.titleize}" }

# Set up the database
run "createuser -s #{app_name}"
rake 'db:create'
rake 'db:test:prepare'

# Generate necessary code
run "bundle install"
run "bundle exec rails generate rspec:install"

run "rm -rf test/; rm -rf README.rdoc; rm -rf public/index.html"
run "git init && git add . && git commit -am 'Initial commit.'"
