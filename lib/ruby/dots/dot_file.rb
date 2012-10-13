module Dots
  class DotFile
    include FileUtils
    include ActiveModel::Validations
    
    validate :untracked_path_is_a_file

    attr_reader :tracked_path

    # Instantiate the file and make sure it exists.
    def initialize with_file_name
      @untracked_path = File.expand_path with_file_name
      @tracked_path = @untracked_path.gsub /#{USER_HOME}/, File.expand_path(DOTS_HOME)
    end

    def to_s
      @untracked_path
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
    end

    def symlink_old_path
      ln @tracked_path, @untracked_path, symbolic: true
    end

    def restore_to_original_path
      mv @tracked_path, @untracked_path
    end

    def delete_symlink
      rm @untracked_path
    end

    def untracked_path_is_a_file
      unless File.exists? @untracked_path
        errors.add :untracked_file, "does not exist"
      end
    end
  end
end
