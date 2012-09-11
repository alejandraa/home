# Application template recipe for the rails_apps_composer. Change the recipe here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/readme.rb

after_everything do
  say_wizard "recipe running after everything"
  
  # remove default READMEs
  %w{
    README
    README.rdoc
    doc/README_FOR_APP
  }.each { |file| remove_file file }

  # add placeholder READMEs and humans.txt file
  copy_from_repo 'public/humans.txt'
  copy_from_repo 'README'
  copy_from_repo 'README.md'
  gsub_file "README", /App_Name/, "#{app_name.humanize.titleize}"
  gsub_file "README.md", /App_Name/, "#{app_name.humanize.titleize}"

  # Diagnostics
  gsub_file "README.md", /recipes that are known/, "recipes that are NOT known" if diagnostics[:recipes] == 'fail'
  gsub_file "README.md", /preferences that are known/, "preferences that are NOT known" if diagnostics[:prefs] == 'fail'
  gsub_file "README.md", /RECIPES/, recipes.sort.inspect
  gsub_file "README.md", /PREFERENCES/, prefs.inspect
  gsub_file "README", /RECIPES/, recipes.sort.inspect
  gsub_file "README", /PREFERENCES/, prefs.inspect
  
  # Ruby on Rails
  gsub_file "README.md", /\* Ruby/, "* Ruby version #{RUBY_VERSION}"
  gsub_file "README.md", /\* Rails/, "* Rails version #{Rails::VERSION::STRING}"
    
  # Database
  gsub_file "README.md", /SQLite/, "PostgreSQL" if prefer :database, 'postgresql'
  gsub_file "README.md", /SQLite/, "MySQL" if prefer :database, 'mysql'
  gsub_file "README.md", /SQLite/, "MongoDB" if prefer :database, 'mongodb'
  gsub_file "README.md", /ActiveRecord/, "the Mongoid ORM" if prefer :orm, 'mongoid'

  # Template Engine
  gsub_file "README.md", /ERB/, "Haml" if prefer :templates, 'haml'
  gsub_file "README.md", /ERB/, "Slim" if prefer :templates, 'slim'

  # Testing Framework
  gsub_file "README.md", /Test::Unit/, "RSpec" if prefer :unit_test, 'rspec'
  gsub_file "README.md", /RSpec/, "RSpec and Cucumber" if prefer :integration, 'cucumber'
  gsub_file "README.md", /RSpec/, "RSpec and Factory Girl" if prefer :fixtures, 'factory_girl'
  gsub_file "README.md", /RSpec/, "RSpec and Machinist" if prefer :fixtures, 'machinist'

  # Front-end Framework
  gsub_file "README.md", /Front-end Framework: None/, "Front-end Framework: Twitter Bootstrap (Sass)" if prefer :bootstrap, 'sass'
  gsub_file "README.md", /Front-end Framework: None/, "Front-end Framework: Twitter Bootstrap (Less)" if prefer :bootstrap, 'less'
  gsub_file "README.md", /Front-end Framework: None/, "Front-end Framework: Zurb Foundation" if prefer :frontend, 'foundation'
  gsub_file "README.md", /Front-end Framework: None/, "Front-end Framework: Skeleton" if prefer :frontend, 'skeleton'
  gsub_file "README.md", /Front-end Framework: None/, "Front-end Framework: Normalized CSS" if prefer :frontend, 'normalize'

  # Form Builder
  gsub_file "README.md", /Form Builder: None/, "Form Builder: SimpleForm" if prefer :form_builder, 'simple_form'

  # Email
  unless prefer :email, 'none'
    gsub_file "README.md", /Gmail/, "SMTP" if prefer :email, 'smtp'
    gsub_file "README.md", /Gmail/, "SendGrid" if prefer :email, 'sendgrid'
    gsub_file "README.md", /Gmail/, "Mandrill" if prefer :email, 'mandrill'
  else
    gsub_file "README.md", /h2. Email/, ""
    gsub_file "README.md", /The application is configured to send email using a Gmail account./, ""
  end

  # Authentication and Authorization
  gsub_file "README.md", /Authentication: None/, "Authentication: Devise" if prefer :authentication, 'devise'
  gsub_file "README.md", /Authentication: None/, "Authentication: OmniAuth" if prefer :authentication, 'omniauth'
  gsub_file "README.md", /Authorization: None/, "Authorization: CanCan" if prefer :authorization, 'cancan'

  git :add => '.' if prefer :git, true
  git :commit => "-aqm 'rails_apps_composer: add README files'" if prefer :git, true
  
end # after_everything

__END__

name: readme_markdown
description: "Build a Markdown README file for your application."
author: tubbo

requires: [setup]
run_after: [setup]
category: configuration
