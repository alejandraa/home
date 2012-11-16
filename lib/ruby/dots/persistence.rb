module Dots
  module Persistence
    include Thor::Actions


    def link_dot_files!
      Dir["config/*"].each do |config_file|
        unless File.directory? config_file or config_file =~ /\.zsh$/
          config_file.gsub!(/config\/|.example/, "")
          config_file_path = File.expand_path "~/.dots/config/#{config_file}"
          dot_file_path = File.expand_path "~/.#{config_file}"

          if File.exists? dot_file_path
            say "Did not symlink #{config_file} since one already exists"
          else
            File.symlink config_file_path, dot_file_path
            say "Symlinked ~/.#{config_file}"
          end
        end
      end

      update
    end


    def persist_dot_file! file_name
      dot_file = Dots::DotFile.new file_name

      if dot_file.save
        say "#{dot_file} saved to DOTS!"
      else
        say "Error: #{dot_file} could not be symlinked:"
        dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
      end
    end


    def forget_dot_file! file_name
      dot_file = Dots::DotFile.find file_name

      if dot_file.destroy
        say "#{dot_file} is no longer being persisted."
      else
        say "Error: #{dot_file} could not be forgotten:"
        dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
      end
    end
  end
end
