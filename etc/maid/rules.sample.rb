# Sample Maid rules file -- a sampling to get you started.
#
# To use, remove ".sample" from the filename.  Test using:
#
#     maid -n
#
# For more help on Maid:
#
#   * Run `maid help`
#   * Read the README at http://github.com/benjaminoakes/maid
#   * For more DSL helper methods, please see the documentation of Maid::Tools at http://rubydoc.info/gems/maid/0.1.0/Maid/Tools
#   * Come up with some cool tools of your own?  Fork, make your changes, and send me a pull request on GitHub!
#   * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)
#
Maid.rules do
  rule "Audio files most likely to be music" do
    %(mp3 wav).each do |ext|
      dir("~/Downloads/*.#{ext}").each do |path|
        if duration_s(path) > 30.0
          move(path, "~/Music/iTunes/iTunes Media/Automatically Add to iTunes/")
        end
      end
    end
  end
  
  rule "Old files downloaded while developing/testing" do
    dir("~/Downloads/*").each do |path|
      if blacklisted? path
        trash path
      end
    end
  end

  rule "Linux ISOs, etc" do
    dir("~/Downloads/*.iso").each { |p| trash p }
  end

  rule "Linux applications in Debian packages" do
    dir("~/Downloads/*.deb").each { |p| trash p }
  end

  rule "Mac OS X applications in disk images" do
    dir("~/Downloads/*.dmg").each { |p| trash p }
  end

  rule "Mac OS X applications in zip files" do
    dir("~/Downloads/*.zip").select { |path|
      candidates = zipfile_contents(path)
      candidates.any? { |c| c.match(/\.app$/) }
    }.each { |p| trash p }
  end

  rule "Misc Screenshots" do
    dir("~/Desktop/Screen shot *").each do |path|
      if 1.week.since?(last_accessed(path))
        move(path, "~/Pictures/Screenshots/")
      end
    end
  end

  def blacklisted? path
    downloaded_from(path).any? { |u| 
      u.match /localhost/ or u.match /(.*)\.elocal\.com/
    } and 1.week.since?(last_accessed(path))
  end
end


