module Dots
  class DotFile
    include FileUtils
    include ActiveModel::Validations
    
    DOTS_HOME = File.expand_path "~/.dots"
    USER_HOME = File.expand_path "~/"

    validate :untracked_path_is_a_file

    attr_reader :tracked_path

    # Instantiate the file and make sure it exists.
    def initialize with_file_name
      @untracked_path = File.expand_path with_file_name
      @file_name = File.basename(with_file_name)[1..-1]
      @tracked_path = "#{DOTS_HOME}/config/#{@file_name}"
    end

    def to_s
      @untracked_path
    end

    def self.find by_file_name
      new by_file_name
    end

    # Persist the file in the ~/.dots repository, and symlink to its old
    # path.
    def save
      if valid?
        move_to_dots and symlink_old_path
      else
        false
      end
    end

    def saved?
      File.exists? @tracked_path and File.exists? @untracked_path
    end

    # "Forget" the file, remove its symlink and restore its location.
    def destroy
      delete_symlink and restore_to_original_path
    end

  private
    def move_to_dots
      mv @untracked_path, @tracked_path
      File.exists? @tracked_path
    end

    def symlink_old_path
      File.symlink(@tracked_path, @untracked_path) == 0
    end

    def restore_to_original_path
      mv @tracked_path, @untracked_path
      File.exists? @untracked_path and not File.symlink? @untracked_path
    end

    def delete_symlink
      rm @untracked_path
      not File.exists? @untracked_path
    end

    def untracked_path_is_a_file
      unless File.exists? @untracked_path
        errors.add :untracked_file, "does not exist"
      end
    end
  end
end
