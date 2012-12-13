#
# Default Rails application template
#

# PostgreSQL for the database, set up this app's user and the DB
database = YAML::load_file("#{Rails.root}/config/database.yml")['development'].symbolize_keys
sh "createuser -s #{database[:user]}"
rake 'db:create'
rake 'db:test:prepare'

# Haml for HTML markup
gem 'haml'
gem 'haml-rails', group: :development
gem 'ruby-parser', group: :development, require: false
gem 'hpricot', group: :development, require: false

# RSpec and Capybara for testing
gem 'rspec-rails', group: :test
gem 'capybara', group: :test

# TODO: Write application config for generators

# Set up a repository
git :init
git add: '.'
git commit: "-a -m 'Initial commit'"
