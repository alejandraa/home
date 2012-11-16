module Persistence
  include Thor::Actions

  desc :link, "Symlink your ~/.dots/config into dotfiles"
  def link
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

  desc :persist, "Copy a dotfile to .dots/config and symlink the original location"
  def persist file_name
    dot_file = Dots::DotFile.new file_name

    if dot_file.save
      say "#{dot_file} saved to DOTS!"
    else
      say "Error: #{dot_file} could not be symlinked:"
      dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
    end
  end

  desc :forget, "Remove the symlink and restore a dotfile back to its original location"
  def forget file_name
    dot_file = Dots::DotFile.find file_name

    if dot_file.destroy
      say "#{dot_file} is no longer being persisted."
    else
      say "Error: #{dot_file} could not be forgotten:"
      dot_file.errors.full_messages.each { |msg| say "- #{msg}" }
    end
  end
end

