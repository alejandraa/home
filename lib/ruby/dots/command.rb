module Dots
  class Command < Thor
    include FileUtils

    desc "Show the current version of DOTS"
    def version
      say "DOTS version #{Dots::VERSION} - http://tubbo.github.com/dots"
    end

    desc "Copy a dotfile to .dots/config and symlink the original location"
    method_option :dot_file, :string
    def persist
      dot_file_without_dot = dot_file.gsub(/\./, '')
      home = `echo $HOME`
      home.gsub!(/\n/, '')

      if mv "#{home}/#{dot_file}", "#{home}/.dots/config/#{dot_file_without_dot}"
        if `ln -s ~/.dots/config/#{dot_file_without_dot} ~/#{dot_file}`
          say "#{dot_file} saved to DOTS!"
          exit 0
        else
          say "Error: #{dot_file} could not be symlinked."
          exit 1
        end
      else
        say "Error: #{dot_file} could not be moved."
        exit 1
      end
    end

    desc "Remove the symlink and restore a dotfile back to its original location"
    method_option :dot_file, :string
    def forget
      dot_file = options[:dot_file]
      dot_file_without_dot = dot_file.gsub(/\./, '')
      home = `echo $HOME`
      home.gsub!(/\n/, '')

      if rm "#{home}/#{dot_file}"
        if mv "#{home}/.dots/config/#{dot_file_without_dot}", "#{home}/#{dot_file}"
          say "#{dot_file} has been removed from your DOTS and restored to its original location."
          exit 0
        else
          say "Error: #{dot_file_without_dot} could not be moved."
          exit 1
        end
      else
        say "Error: #{dot_file} symlink could not be removed."
        exit 1
      end
    end
  end
end
