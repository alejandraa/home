# Application template recipe for the rails_apps_composer. Check for a newer version here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/html5.rb

after_bundler do
  say_wizard "HTML5 recipe running 'after bundler'"
  # add a humans.txt file
  get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/humans.txt', 'public/humans.txt'
  # install a front-end framework for HTML5 and CSS3
  remove_file 'app/assets/stylesheets/application.css'
  remove_file 'app/views/layouts/application.html.erb'
  remove_file 'app/views/layouts/application.html.haml'
  unless recipes.include? 'bootstrap'
    if recipes.include? 'haml'
      # Haml version of a simple application layout
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/simple/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/simple/views/layouts/_messages.html.haml', 'app/views/layouts/_messages.html.haml'
    else
      # ERB version of a simple application layout
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/simple/views/layouts/application.html.erb', 'app/views/layouts/application.html.erb'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/simple/views/layouts/_messages.html.erb', 'app/views/layouts/_messages.html.erb'
    end
    # simple css styles
    get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/simple/assets/stylesheets/application.css.scss', 'app/assets/stylesheets/application.css.scss'  
  else # for Twitter Bootstrap
    if recipes.include? 'haml'
      # Haml version of a complex application layout using Twitter Bootstrap
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/twitter-bootstrap/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/twitter-bootstrap/views/layouts/_messages.html.haml', 'app/views/layouts/_messages.html.haml'
    else
      # ERB version of a complex application layout using Twitter Bootstrap
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/twitter-bootstrap/views/layouts/application.html.erb', 'app/views/layouts/application.html.erb'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/twitter-bootstrap/views/layouts/_messages.html.erb', 'app/views/layouts/_messages.html.erb'
    end
    # complex css styles using Twitter Bootstrap
    get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/twitter-bootstrap/assets/stylesheets/application.css.scss', 'app/assets/stylesheets/application.css.scss'
  end
  # get an appropriate navigation partial
  if recipes.include? 'haml'
    if recipes.include? 'devise'
      if recipes.include? 'authorization'
        get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/devise/authorization/_navigation.html.haml', 'app/views/layouts/_navigation.html.haml'
      else
        get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/devise/_navigation.html.haml', 'app/views/layouts/_navigation.html.haml'        
      end
    elsif recipes.include? 'omniauth'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/omniauth/_navigation.html.haml', 'app/views/layouts/_navigation.html.haml'
    elsif recipes.include? 'subdomains'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/subdomains/_navigation.html.haml', 'app/views/layouts/_navigation.html.haml'
    else
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/none/_navigation.html.haml', 'app/views/layouts/_navigation.html.haml'
    end
  else
    if recipes.include? 'devise'
      if recipes.include? 'authorization'
        get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/devise/authorization/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'
      else
        get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/devise/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'        
      end
    elsif recipes.include? 'omniauth'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/omniauth/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'
    elsif recipes.include? 'subdomains'
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/subdomains/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'
    else
      get 'https://raw.github.com/RailsApps/rails3-application-templates/master/files/navigation/none/_navigation.html.erb', 'app/views/layouts/_navigation.html.erb'
    end
  end
  if recipes.include? 'haml'
    gsub_file 'app/views/layouts/application.html.haml', /App_Name/, "#{app_name.humanize.titleize}"
    gsub_file 'app/views/layouts/_navigation.html.haml', /App_Name/, "#{app_name.humanize.titleize}"
  else
    gsub_file 'app/views/layouts/application.html.erb', /App_Name/, "#{app_name.humanize.titleize}"
    gsub_file 'app/views/layouts/_navigation.html.erb', /App_Name/, "#{app_name.humanize.titleize}"
  end
end

__END__

name: html5
description: "Install HTML5 boilerplate code."
author: tubbo

requires: [setup, gems, frontend]
run_after: [setup, gems, frontend]
category: frontend
