task :config do
  Dir["config/*"].each do |config_file|
    unless File.directory? config_file
      config_file.gsub! /config\/|.example/, ""
      config_file_path = File.expand_path "~/.dots/config/#{config_file}"
      dot_file_path = File.expand_path "~/.#{config_file}"
      global_rake_path = File.expand_path "~/.rake"

      if File.exists? dot_file_path
        puts "Did not symlink #{config_file} since one already exists"
      else
        File.symlink config_file_path, dot_file_path
        puts "Symlinked ~/.#{config_file}"
      end

      unless File.exists? global_rake_path
        File.symlink global_rake_path, File.expand_path("~/.dots/lib/tasks")
      end
    end
  end
  puts "Please reload your DOTS."
end

desc "Update all installed plugins"
task :update do
  sh "cd ~/.dots && git pull origin master"

  antigen_repos = Dir[File.join(File.expand_path("../.antigen/repos"), "*")]
  antigen_repos.each do |repo|
    sh "cd #{repo} && git pull origin master"
  end
end
