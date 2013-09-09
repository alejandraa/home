def database
  YAML::load_file(config_path)[rails_env].with_indifferent_access
end

def config_path
  File.expand_path "../../config/database.yml", __FILE__
end

def rails_env
  ENV['RAILS_ENV'] || 'development'
end

namespace :db do
  task :user do
    sh "createuser -s #{database[:username]}"
  end
end

task :db => %w(db:user db:setup)
