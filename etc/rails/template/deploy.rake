namespace :deploy do
  task :ssh_configuration do
    ssh_config = %(
    Host heroku.com
      StrictHostKeyChecking no
      CheckHostIP no
      UserKnownHostsFile=/dev/null
    )
    File.write(File.expand_path("~/.ssh/config"), 'rw+') do |f|
      f.puts ssh_config
    end
  end

  task :heroku_keys do
    sh 'yes | heroku keys:clear'
    sh 'yes | heroku keys:add'
  end

  task :application_to_heroku do
    APP_NAME = ENV['HEROKU_APP_NAME']
    sh "git remote add heroku git@heroku.com:#{APP_NAME}.git"
    sh 'git push heroku master'
  end
end

desc "Deploy to Heroku from Travis-CI"
task :deploy => %w(
  deploy:ssh_configuration
  deploy:heroku_keys
  deploy:application_to_heroku
  airbrake:deploy
)
