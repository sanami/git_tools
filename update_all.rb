require 'pp'

class Tools
  ##
  # Recursively update git repos
  def git_update_all
    find_dirs do
      `git pull`
    end
  end

private
  ##
  # Find all folders with git repos in .git
  def find_dirs(dir_name = '.', &action)
    Dir.foreach('.') do |dir|
      next unless File.directory? dir
      next if dir == '.' || dir == '..'

      Dir.chdir dir do
        if File.exists? '.git'
          puts '*'*11 + ' ' + Dir.getwd
          action.call

        else
          # Recursion
          find_dirs &action
        end
      end

    end
  end
end


if __FILE__ == $0
  t = Tools.new
  Dir.chdir '/home/sa/repos/meego' do
		t.git_update_all
  end
end
