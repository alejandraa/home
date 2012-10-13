require 'spec_helper'
require 'dots/command'

describe Dots::Command do
  before do
    dot_file = File.expand_path("~/.dot_file")
    %x(touch #{dot_file}) unless File.exists? dot_file
  end

  describe "persist PATH" do
    let(:subject) { %x(./bin/dots persist ~/.dot_file) }

    it "copies the file to the dots repo" do
      subject.should_not be_blank
    end
  end

  describe "forget PATH" do
    let(:subject) { %x(./bin/dots forget ~/.dot_file) }

    it "restores the file to its original location" do
      subject.should_not be_blank
    end
  end

  describe "bare invocation" do
    let(:subject) { %x(./bin/dots) }

    it "shows usage information" do
      subject.should_not be_blank
    end
  end
end

