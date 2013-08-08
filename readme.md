git-camera
===

Have you ever finished a website and thought about how the design/build has evolved to get where it is now? Well git-camera is for you!

git-camera goes through your (web) project's git commits, and records a video of how the interface has changed over time. It's a little window into your build process - Use it for your own curiosity, show it to your client, your boss, investors, your cat, or your therapist (who may also be your cat).


Installation
---

If needs PhantomJS, FFmpeg, and Ruby. You probably already have Ruby, and if you're on a Mac you can get the others with:

        brew install phantomjs ffmpeg

If that gave you an error, you probably need to install homebrew first: `$ ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)`


The simplest way is to install via rubygems. You don't need to know anything about Ruby, it comes with OSX and is just a delivery system.

        $ [sudo] gem install git-camera

Alternatively, run from the source.

Usage
---

cd project_directory
git-camera

You can provide options, or use a config file. I'd recommend a config file.


If you need any help with this, I'm @skattyadz on Twitter
