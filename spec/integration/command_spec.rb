require 'spec_helper'
require 'dots/command'

describe Dots::Command do
  before do
    dot_file = File.expand_path("~/.dot_file")
    %x(touch #{dot_file}) unless File.exists? dot_file
  end

  describe "persist PATH" do
    subject { %x(./bin/dots persist ~/.dot_file) }

    it "copies the file to the dots repo"
  end

  describe "forget PATH" do
    subject { %x(./bin/dots forget ~/.dot_file) }

    it "restores the file to its original location"
  end

  describe "bare invocation" do
    subject { %x(./bin/dots) }

    it "shows usage information"
  end
end

