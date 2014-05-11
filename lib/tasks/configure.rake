namespace :configure do
  task :shell do
    Dir["#{HOME_DIR}/.dots/config/*"].each do |dot_file_path|
      unless dot_file_path =~ /\.zsh\Z|\.example\Z|packages\.yml/
        dot_file = File.basename dot_file_path
        link_path = "#{HOME_DIR}/.#{dot_file}"
        `ln -s #{dot_file_path} #{link_path}` unless File.exists? link_path
      end
    end
  end
end

desc "Symlink all configuration stored in the repo"
task :configure => %w(configure:shell)
