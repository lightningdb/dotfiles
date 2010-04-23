# Simple script for adding and updating vim bundles to your setup.
# 
# Throw it into your .vim diretory.
#
#   cd ~/.vim
#   thor vim:update
#   thor vim:add git://github.com/tpope/vim-rails.git
#
require 'pathname'
require 'pp'

class ::Pathname
  def ls
    entries.reject {|p| p.to_s[0] == ?.}
  end
end

class Vim < Thor
  desc 'update', 'Update as many bundles as possible.'
  def update
    bundle_path.mkpath

    bundle_path.ls.select {|p| p.directory?}.each do |p|
      if git?(p)
        update_git(p)
      else
        update_site(p)
      end
    end
  end

  desc 'add [REPO]', 'add REPO from github'
  method_option :name, :alias => 'n', :type => :string, :banner => 'The name of the clone.'
  def add(repo)
    bundle_path.mkpath

    Dir.chdir(dotgit.parent) do
      if options.name?
        name = params.name
      else
        name = repo[/([^\/]+)\.git$/,1]
      end

      system "git submodule add #{repo} #{bundle_path+name}".tap {|s| puts "running #{s}"}
    end
  end

	protected
  def update_git
    Dir.chdir(path) do
      system("git pull")
    end
  end

  def update_site(p)
    # to add
  end

  def bundle_path
    @bundle_path ||= dotvim + 'bundle'
  end

  def dotvim
		@dotvim ||= Pathname("~/.vim").expand_path
  end

  def dotgit
    @dotgit ||= Pathname(`git rev-parse --git-dir`.chomp).expand_path
  end

  def git?(path)
    Dir.chdir(path) do
      system("git rev-parse --is-inside-work-tree")
    end

    $?.success?
  end
end

# vim: ft=ruby
