require 'rake'

namespace :heroku do
  desc "Push environment variables in .env to Heroku"
  task :config do
    env_file = IO.read File.expand_path(".env")
    configuration = env_file.split("\n").reduce("") { |settings,line|
      this_setting = line.gsub(/\Aexport|;/, '')
      settings += "#{this_setting} "
    }.strip

    sh "heroku config:add #{configuration}"
  end
end
