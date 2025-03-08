# lib/cookies/cookies_handler.rb
require 'open3'
require_relative '../errors'

module Ghost
  module Cookies
    class CookiesHandler
      def initialize(url, cookies_file)
        @url = url
        @cookies_file = cookies_file
      end

      def download
        # Check if cookies file exists
        unless File.exist?(@cookies_file)
          raise Ghost::Errors::DownloadError, "Cookies file does not exist: #{@cookies_file}"
        end
        
        command = "yt-dlp --cookies #{@cookies_file} -f \"bestvideo+bestaudio/best\" --merge-output-format mp4 #{@url}"
        puts "Executing download with cookies command: #{command}"
        
        stdout_str, stderr_str, status = Open3.capture3(command)
        if status.success?
          puts "Download with cookies completed successfully!"
          stdout_str
        else
          puts "Error during download with cookies: #{stderr_str}"
          raise Ghost::Errors::DownloadError, "Error during download with cookies: #{stderr_str}"
        end
      end
    end
  end
end