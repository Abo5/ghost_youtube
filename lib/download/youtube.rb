# lib/download/youtube.rb
require 'open3'
require_relative '../errors'

module Ghost
  module Download
    class Youtube
      def initialize(url, options = {})
        @url = url
        @quality = options.fetch(:quality, "best")
        @sounde = options.fetch(:sounde, true)
        @progress = options.fetch(:progress, nil)
      end

      def download
        command = build_command
        # Print the command for debugging
        puts "Executing command: #{command}"
        
        if @progress
          download_with_progress(command, @progress)
        else
          download_without_progress(command)
        end
      end

      private

      def build_command
        if @sounde
          # Modified command to ensure both video and audio are downloaded
          "yt-dlp -f \"bestvideo+bestaudio/best\" --merge-output-format mp4 #{@url}"
        else
          "yt-dlp -f bestvideo #{@url}"
        end
      end

      def download_without_progress(command)
        stdout_str, stderr_str, status = Open3.capture3(command)
        if status.success?
          puts "Download completed successfully!"
          stdout_str
        else
          puts "Error during download: #{stderr_str}"
          raise Ghost::Errors::DownloadError, "Error during download: #{stderr_str}"
        end
      end

      def download_with_progress(command, progress_style)
        puts "Starting download with progress display..."
        Open3.popen2e(command) do |stdin, stdout_err, wait_thr|
          while (line = stdout_err.gets)
            puts line if line.include?("Merging") # Print merging logs for debugging
            if match = line.match(/(\d+\.\d+)%/)
              percentage = match[1].to_f
              print_progress_bar(percentage, progress_style)
            end
          end
          exit_status = wait_thr.value
          unless exit_status.success?
            raise Ghost::Errors::DownloadError, "Error during download with progress"
          end
          puts "\nDownload completed successfully!"
        end
      end

      def print_progress_bar(percentage, progress_style)
        total_length = 20
        filled_length = (percentage.to_f / 100 * total_length).round
        bar = progress_style * filled_length
        print "\r#{bar} %#{percentage.round(1)}"
        $stdout.flush
      end
    end
  end
end