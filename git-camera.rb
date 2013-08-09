#!/usr/bin/env ruby

$LOAD_PATH << './lib'
require 'capture'

pointless_ascii_camera = <<-EOS
              ____
         _[]_/____\\__n_
        |_____.--.__()_|
        |LI  //# \\\\    |
        |    \\\\__//    |
        |     '--'     |
        '--------------'
EOS
# borrowed without much asking from http://www.chris.com/ascii/index.php?art=objects%2Fcameras
puts pointless_ascii_camera

@c = GitCamera::Capture.instance

def before_all(command=nil, &block)
  @c.before_all_command = command
  @c.before_all_block = block
end
def before_each(command=nil, &block)
  @c.before_each_command = command
  @c.before_each_block = block
end
def after_all(command=nil, &block)
  @c.after_all_command = command
  @c.after_all_block = block
end
def after_each(command=nil, &block)
  @c.after_each_command = command
  @c.after_each_block = block
end

def page_url(url)
  @c.page_url = url
end

def repo_path(path)
  @c.repo_path = path
end

def resolution(res)
  @c.resolution = res
end

def delay(delay_amount)
  @c.delay = delay_amount
end

def frames_per_second(fps)
  @c.fps = fps
end

load 'git-cam.conf'

@c.start_capture
