require 'grit'

pointless_ascii_delorean = <<-EOS
  __---~~~~--__                      __--~~~~---__
 `\\---~~~~~~~~\\\\                    //~~~~~~~~---/'
   \\/~~~~~~~~~\\||                  ||/~~~~~~~~~\\/
               `\\\\                //'
                 `\\\\            //'
                   ||          ||
         ______--~~~~~~~~~~~~~~~~~~--______
    ___ // _-~                        ~-_ \\\\ ___
   `\\__)\\/~                              ~\\/(__/'
    _--`-___                            ___-'--
  /~     `\\ ~~~~~~~~------------~~~~~~~~ /'     ~\\
 /|        `\\         ________         /'        |\\
| `\\   ______`\\_      \\------/      _/'______   /' |
|   `\\_~-_____\\ ~-________________-~ /_____-~_/'   |
`.     ~-__________________________________-~     .'
 `.      [_______/----DELOREAN----\\_______]      .'
  `\\--___((____)(________\\/________)(____))___--/'
   |>>>>>>||                            ||<<<<<<|
   `\\<<<<</'                            `\\>>>>>/'
EOS
# borrowed without much asking from http://www.chris.com/ascii/index.php?art=transportation%2Fcars
puts pointless_ascii_delorean


def before_all(command=nil, &block)
  @before_all_command = command
  @before_all_block = block
end
def before_each(command=nil, &block)
  @before_each_command = command
  @before_each_block = block
end
def after_all(command=nil, &block)
  @after_all_command = command
  @after_all_block = block
  end
def after_each(command=nil, &block)
  @after_each_command = command
  @after_each_block = block
end


page_url = "http://tomodell.dev"
repo_dir = "/Users/skattyadz/Dropbox/code/tomodell"

repo = Grit::Repo.new(repo_dir)
# puts repo.commits

@before_all_block && @before_all_block.call

repo.commits.each do |commit|
  @before_each_block && @before_each_block.call

  repo.git.native :checkout, {:'--work-tree'=> repo_dir}, commit.sha
  destination = "#{commit.sha}.png"
  @setup_block && @setup_block.call
#   get unique destination path
  
  `phantomjs phantom_task.js #{page_url} #{destination}`

  @after_each_block && @after_each_block.call
end

@after_all_block && @after_all_block.call


# compile images into video
# delete images
repo.git.native :checkout, {}, 'master'

