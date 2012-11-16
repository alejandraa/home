module Installation
  def copy_to_home_directory!
    system "mkdir -p #{Dots.home} cp -R #{Dots.root} #{Dots.home}"
  end

  def pull_from_origin!
    system "cd #{Dots.home} && git pull --rebase origin master"
  end
end
