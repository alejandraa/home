#
# Default Rails application template
#

templates = File.expand_path '~/etc/rails/template'

# Set up the template engine and test framework to use when generating
# new resources in the course of development.
initializer "generators.rb", <<-RUBY
Rails.application.config.generators do |g|
  g.template_engine :haml
  g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
end
RUBY

# Create a Procfile for running the server and other workers as they
# become available.
file "Procfile" do
  <<-RUBY
web: bundle exec rails server puma
  RUBY
end

# Set up the shell environment and CI configuration
%w(env travis.yml gitignore).each do |name|
  file(".#{name}") { IO.read File.expand_path("~/etc/rails/template/#{name}") }
end

# Generate the README and remove the default one
run "rm -rf README.rdoc"
file("README.md") { "# #{app_name.titleize}" }

# Set up the database
run "createuser -s #{app_name}"

# Remove the Rails tests
run "rm -rf test/"

# Remove unnecessary default files
run "rm -rf public/index.html"

# Add necessary gems
run "rm -rf Gemfile"
file('Gemfile') { IO.read File.join(templates, 'Gemfile') }

# Initialize the repository
git :init
git add: '.'
git commit: '-am "Initial commit."'
