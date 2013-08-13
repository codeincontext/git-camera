require 'singleton'
require 'grit'

module GitCamera
  class Capture
    include Singleton

    attr_accessor :before_all_command, :before_all_block, :before_each_command, :before_each_block
    attr_accessor :after_all_command, :after_all_block, :after_each_command, :after_each_block

    attr_accessor :page_url, :repo_path, :resolution, :delay, :fps

    def start_capture

      repo = Grit::Repo.new(repo_path || Dir.getwd)

      before_all_block.call if before_all_block
      puts 'Snapping:'

      repo.commits('master', 99999).reverse.each_with_index do |commit, i|
        before_each_block.call if before_each_block

        repo.git.native :checkout, {:raise=>true}, commit.sha
        destination = "frame_#{"%05d" % i}.png"
        before_each_block.call if before_each_block
      #   get unique destination path

        take_screenshot(destination)
        puts '- '+commit.message

        after_each_block.call if after_each_block
      end

      compile_to_video

      delete_images

      after_all_block.call if after_all_block

      # compile images into video
      # delete images
      repo.git.native :checkout, {}, 'master'
    end

  private

    def take_screenshot(destination)
      phantom_task_path = File.expand_path(File.dirname(__FILE__))

      phantom_command = [
        'phantomjs', 
        "#{phantom_task_path}/../phantom_task.js",
        page_url, 
        destination,
        resolution,
        delay
      ].join(' ')

      system phantom_command
    end

    def compile_to_video
      `ffmpeg -f image2 -r #{fps} -i frame_%05d.png -y output.mp4`
    end

    def delete_images

    end

  end
end
