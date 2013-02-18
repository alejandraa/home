# Some modern modifications to the standard Rails application builder.
class ModernBuilder < Rails::AppBuilder
  attr_accessor :devise_requested

  # Use Markdown instead of RDoc
  def readme
    create_file "README.md", "# #{app_name.titleize}"
  end

  # Use RSpec instead of Minitest
  def test
    run 'bundle install'
    generate 'rspec:install'
  end

  # Use Haml, Foreman, Draper and ActiveModelSerializers as well
  # as other helpful testing gems.
  def gemfile
    super
    self.devise_requested = ask? "Would you like to install Devise?"
    @generator.gem 'devise' if devise_requested
    @generator.gem 'haml'
    @generator.gem 'foreman'
    @generator.gem 'draper'
    @generator.gem 'active_model_serializers'

    @generator.gem_group :development do
      @generator.gem 'haml-rails'
      @generator.gem 'ruby_parser'
      @generator.gem 'hpricot'
      @generator.gem 'puma'
    end

    @generator.gem_group :test do
      @generator.gem 'rspec-rails'
      @generator.gem 'capybara'
    end
  end

  # Set up the Travis-CI, Shell and generator configuration
  def leftovers
    copy_configuration
    initialize_generators
    install_devise if devise_requested
    remove_garbage
    create_repository
  end

private
  def copy_configuration
    %w(.env .travis.yml Procfile).each do |name|
      file(name) { IO.read File.expand_path("~/etc/rails/template/#{name}") }
    end
  end

  def initialize_generators
    initializer "generators.rb", <<-RUBY
    Rails.application.config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, fixtures: true, fixture_location: "spec/fixtures"
    end
    RUBY
  end

  def install_devise
    generate 'devise:install'
    append_file 'config/application.rb', <<-RUBY
    Rails.application.config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    RUBY
    generate 'devise user'
  end

  def remove_garbage
    run "rm -rf public/index.html"
  end

  def set_up_database
    run "createuser -s #{app_name}"
    rake 'db:create'
    rake 'db:test:prepare'
  end

  def create_repository
    git :init
    git add: '.', commit: "-m 'Initial commit'"
  end
end
