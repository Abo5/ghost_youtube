# lib/caption/youtube_caption.rb
require 'open3'
require_relative '../errors'

module Ghost
  module Caption
    class YoutubeCaption
      def initialize(url, language = 'en')
        @url = url
        @language = language
      end

      def download
        command = "yt-dlp --write-auto-sub --sub-lang #{@language} --skip-download #{@url}"
        stdout_str, stderr_str, status = Open3.capture3(command)
        if status.success?
          stdout_str
        else
          raise Ghost::Errors::CaptionError, "Error during caption download: #{stderr_str}"
        end
      end
    end
  end
end
