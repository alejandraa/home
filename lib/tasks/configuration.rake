namespace :config do
  task :link do
    Dir["config/*"].each do |config_file|
      unless File.directory? config_file
        config_file.gsub! /config\/|.example/, ""
        config_file_path = File.expand_path "~/.dots/config/#{config_file}"
        dot_file_path = File.expand_path "~/.#{config_file}"

        if File.exists? dot_file_path
          puts "Did not symlink #{config_file} since one already exists"
        else
          File.symlink config_file_path, dot_file_path
          puts "Symlinked ~/.#{config_file}"
        end
      end
    end
    puts "Please reload your DOTS."
  end
end
