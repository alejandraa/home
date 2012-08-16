after_bundler do
  say_wizard "recipe running after 'bundle install'"

  # Convert all views to Haml
  run "for i in `find app/views -name '*.erb'` ; do html2haml -e $i ${i%erb}haml ; rm $i ; done"

  ### GIT ###
  git :add => '.' if prefer :git, true
  git :commit => "-aqm 'rails_apps_composer: Haml starter views.'" if prefer :git, true
end # after_bundler

__END__

name: haml_views
description: "Convert views to Haml"
author: tubbo

requires: [setup, gems, auth, models, controllers, views]
run_after: [setup, gems, auth, models, controllers, views]
category: mvc
