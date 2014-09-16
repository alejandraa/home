#
# Default Rails application template
#

def template_path template_name
  File.expand_path "~/etc/rails/template/#{template_name}"
end

def template_for name
  IO.read template_path(name)
end

def erb_template_for name
  ERB.new template_for("#{name}.erb")
end

def latest_ruby_version
  Dir["#{ENV['HOME']}/.rubies/*"].map { |rbdir|
    File.basename rbdir.gsub(/(rubinius|ruby)-/, '')
  }.last
end

# Set up the template engine and test framework to use when generating
# new resources in the course of development.
initializer "generators.rb", <<-RUBY
Rails.application.config.generators do |g|
  g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
end
RUBY

# Create a Procfile for running the server and other workers as they
# become available.
file "Procfile" do
  <<-RUBY
web: bundle exec rails server
  RUBY
end

# Set up the shell environment and CI configuration
%w(env travis.yml gitignore ruby-version).each do |name|
  file(".#{name}") { template_for(name) }
end

# Replace db/seeds.rb
file("db/seeds.rb") { template_for 'seeds.rb' }

# Generate the README and remove the default one
run "rm README.rdoc"
file("README.md") { "# #{app_name.titleize}" }

# Set up the database
run "createuser -s #{app_name}"

# Remove the Rails tests
run "rm -r test/"

# Override application.rb
app_config = "config/application.rb"
run "rm #{app_config}"
file app_config, erb_template_for(app_config).result(binding)

# Add necessary gems
run "rm Gemfile"
file('Gemfile') { erb_template_for('Gemfile').result(binding) }

# Initialize the repository
git :init
git add: '.'
git commit: '-am "Initial commit."'
