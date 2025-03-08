
# ghost_youtube.rb

# Ensure that yt-dlp is installed on the system.
def ensure_yt_dlp_installed
  unless system("command -v yt-dlp > /dev/null 2>&1")
    raise LoadError, "yt-dlp is not installed. Please install it from https://github.com/yt-dlp/yt-dlp"
  end
end

ensure_yt_dlp_installed

require_relative 'lib/errors'
require_relative 'lib/download/youtube'
require_relative 'lib/download/vimeo'
require_relative 'lib/caption/youtube_caption'
require_relative 'lib/cookies/cookies_handler'

module Ghost
  module Download
    # DSL method for downloading a YouTube video.
    # Example usage:
    #   Ghost::Download.youtube("url", sounde: true, quality: "best", pro: "#")
    def self.youtube(url, options = {})
      sound = options.fetch(:sounde, true)
      # Fix spelling error in parameter name from qualtiy to quality
      quality = options.fetch(:quality, "best") 
      # For backward compatibility with existing code
      quality = options.fetch(:qualtiy, quality) if options.key?(:qualtiy)
      progress_style = options.fetch(:pro, nil)
      
      # Print debug information
      puts "Downloading video from: #{url}"
      puts "Video quality: #{quality}"
      puts "Audio enabled: #{sound}"
      
      downloader = Download::Youtube.new(url, quality: quality, sounde: sound, progress: progress_style)
      downloader.download
    end

    # DSL method for downloading a Vimeo video.
    def self.vimeo(url, options = {})
      downloader = Download::Vimeo.new(url, options)
      downloader.download
    end
  end

  module Caption
    # DSL method for downloading YouTube captions.
    # Example usage:
    #   Ghost::Caption.youtube("url", language: "en")
    def self.youtube(url, language: 'en')
      caption_downloader = Caption::YoutubeCaption.new(url, language)
      caption_downloader.download
    end
  end

  module Cookies
    # DSL method for downloading a YouTube video using cookies.
    # Example usage:
    #   Ghost::Cookies.youtube("url", cookies_file: "path/to/cookies.txt")
    def self.youtube(url, cookies_file:)
      cookies_handler = Cookies::CookiesHandler.new(url, cookies_file)
      cookies_handler.download
    end
  end
end
