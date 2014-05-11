
namespace :update do
  task :framework do
    sh %(
      cd #{HOME}/.dots &&
      git pull --rebase origin master &&
      git submodule sync &&
      git submodule update &&
      antigen-update
    )
  end
end


desc "Update DOTS, Antigen, and all installed plugins."
task :update => %w(update:framework configure)
