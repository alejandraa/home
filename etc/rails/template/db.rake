namespace :db do
  task :user do
    sh 'createuser -s wax_poetic'
  end
end

task :db => %w(db:user db:setup)
