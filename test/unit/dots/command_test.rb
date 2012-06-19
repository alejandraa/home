require 'test_helper'

class Dots::CommandTest < ActiveSupport::TestCase
  context "CommandTest - Persist a dotfile" do
    should "copy a dotfile to .dots/config" do

    end

    should "symlink the original location of the dotfile to the new location" do

    end
  end

  context "CommandTest - Forget a dotfile" do
    should "delete the symlink in the home directory" do

    end

    should "move the dotfile from .dots/config to home directory" do

    end
  end
end
