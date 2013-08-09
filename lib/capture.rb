require 'singleton'
require 'grit'

module GitCamera
  class Capture
    include Singleton

    attr_accessor :before_all_command, :before_all_block, :before_each_command, :before_each_block
    attr_accessor :after_all_command, :after_all_block, :after_each_command, :after_each_block

    attr_accessor :page_url, :repo_path, :delay

    def start_capture

      repo = Grit::Repo.new(repo_path)

      before_all_block.call if before_all_block
      puts 'Snapping:'

      repo.commits.reverse.each do |commit|
        before_each_block.call if before_each_block

        repo.git.native :checkout, {:'--work-tree'=> repo_path}, commit.sha
        destination = "#{commit.sha}.png"
        before_each_block.call if before_each_block
      #   get unique destination path
        
        `phantomjs phantom_task.js #{page_url} #{destination} #{delay}`
        puts '- '+commit.message

        after_each_block.call if after_each_block
      end

      after_all_block.call if after_all_block

      # compile images into video
      # delete images
      repo.git.native :checkout, {}, 'master'
    end

  end
end
