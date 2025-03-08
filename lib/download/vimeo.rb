# lib/download/vimeo.rb
require 'open3'
require_relative '../errors'

module Ghost
  module Download
    class Vimeo
      def initialize(url, options = {})
        @url = url
      end

      def download
        command = "yt-dlp #{@url}"
        result = system(command)
        raise Ghost::Errors::DownloadError, "Error during Vimeo download" unless result
      end
    end
  end
end
