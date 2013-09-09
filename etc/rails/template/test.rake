namespace :test do
  namespace :prepare do
    desc "Start xvfb"
    task :xvfb do
      sh %(
        export DISPLAY=:99.0;
        sh -e /etc/init.d/xvfb start;
      )
    end
  end
end
