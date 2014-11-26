require 'rake'

namespace :gems do
  desc "Install each RubyGem in ~/.rbenv/default-gems"
  task :install do
    gemset = IO.read File.expand_path('~/.rbenv/default-gems')
    gemset.split("\n").each do |line|
      name, version = line.split "\s"
      command = if version =~ /\A~>/ # up to a specific version
        "gem install #{name} -v #{version.gsub('~>', '')}"
      elsif version.nil? # latest version
        "gem install #{name}"
      else # --pre, exact gem versions, etc.
        "gem install #{name} #{version}"
      end

      if system("gem which #{name}")
        puts "Already installed #{name}"
      else
        sh command
      end
    end
  end
end
