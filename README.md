# Ghost YouTube Library

A lightweight Ruby gem for downloading videos, captions, and handling cookies with YouTube and Vimeo.

## Requirements

* Ruby 2.5+
* [yt-dlp](https://github.com/yt-dlp/yt-dlp) must be installed on your system

## Installation

```bash
# Install yt-dlp first
pip install -U yt-dlp

# Install the gem
gem install ghost_youtube
```

Or add it to your Gemfile:

```ruby
gem 'ghost_youtube'
```

## Features

- Download YouTube videos with progress bar
- Download YouTube videos with specific quality
- Download YouTube captions
- Support for YouTube Shorts
- Support for Vimeo videos
- Support for using cookies to download videos

## Usage Examples

### 1. Basic Video Download

```ruby
require 'ghost_youtube'

# Download a YouTube video with default options
video = Ghost::Download.youtube("https://www.youtube.com/watch?v=ocV8fBuzeh8")

# Download with full path
puts "Video saved to: #{video}"
```

### 2. Download with Progress Bar

```ruby
require 'ghost_youtube'

# Download a YouTube video with a progress bar using "#" character
url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"
Ghost::Download.youtube(url, pro: "#")

# You can use any character for the progress bar
Ghost::Download.youtube(url, pro: "█")
```

### 3. Download with Quality Settings

```ruby
require 'ghost_youtube'

url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"

# Download best quality
Ghost::Download.youtube(url, quality: "best")

# Download specific resolution
Ghost::Download.youtube(url, quality: "bestvideo[height<=720]+bestaudio")

# Video-only download (no audio)
Ghost::Download.youtube(url, sounde: false)
```

### 4. Download YouTube Shorts

```ruby
require 'ghost_youtube'

# YouTube Shorts work the same way as regular videos
shorts_url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"
Ghost::Download.youtube(shorts_url, quality: "best", pro: "#")
```

### 5. Download YouTube Captions

```ruby
require 'ghost_youtube'

# Download captions in English
url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"
captions = Ghost::Caption.youtube(url, language: "en")
puts "Caption file saved to: #{captions}"

# Download captions in a different language
captions_es = Ghost::Caption.youtube(url, language: "es")
```

### 6. Download Using Cookies

```ruby
require 'ghost_youtube'

# Download a video using cookies (for age-restricted or private videos)
url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"
cookies_path = "/path/to/your/cookies.txt"
video = Ghost::Cookies.youtube(url, cookies_file: cookies_path)
```

### 7. Download Vimeo Videos

```ruby
require 'ghost_youtube'

# Download a Vimeo video
vimeo_url = "https://vimeo.com/12345678"
Ghost::Download.vimeo(vimeo_url)
```

### 8. Complete Example Script

```ruby
require 'ghost_youtube'

puts "==== Ghost YouTube Downloader Demo ===="

# Define a video to download
video_url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"

# Download a YouTube video with progress bar
puts "\n[1] Downloading video with progress bar..."
Ghost::Download.youtube(video_url, sounde: true, quality: "best", pro: "#")

# Download captions if available
puts "\n[2] Downloading captions..."
begin
  Ghost::Caption.youtube(video_url, language: "en")
rescue => e
  puts "Captions not available or error: #{e.message}"
end

# Download a YouTube Shorts
puts "\n[3] Downloading a YouTube Shorts..."
shorts_url = "https://www.youtube.com/watch?v=ocV8fBuzeh8"
Ghost::Download.youtube(shorts_url, quality: "best", pro: "=")

puts "\nDownloads completed!"
```

## Cookies Format

For age-restricted videos or videos that require login, you need to provide a cookies file.
You can export cookies from your browser using extensions like "Get cookies.txt" or "EditThisCookie".

The cookies file should be in Netscape format:

```
# Netscape HTTP Cookie File
.youtube.com	TRUE	/	FALSE	1739582099	GPS	1
.youtube.com	TRUE	/	FALSE	1739582099	VISITOR_INFO1_LIVE	aBcDeFgHiJk
.youtube.com	TRUE	/	FALSE	1739582099	YSC	AbCdEfGhIjK
```

## API Reference

### Download Module

- `Ghost::Download.youtube(url, options = {})`
  - `url`: YouTube video URL
  - `options`:
    - `sounde`: Boolean (default: true) - Download with audio
    - `quality`: String (default: "best") - Quality selection
    - `pro`: String or nil (default: nil) - Progress bar character

- `Ghost::Download.vimeo(url, options = {})`
  - `url`: Vimeo video URL
  - `options`: Currently not used

### Caption Module

- `Ghost::Caption.youtube(url, language: 'en')`
  - `url`: YouTube video URL
  - `language`: String (default: 'en') - Caption language code

### Cookies Module

- `Ghost::Cookies.youtube(url, cookies_file:)`
  - `url`: YouTube video URL
  - `cookies_file`: Path to cookies file in Netscape format

## How It Works

Ghost YouTube uses the powerful [yt-dlp](https://github.com/yt-dlp/yt-dlp) program under the hood, 
which is a feature-rich YouTube-DL fork with additional features and fixes.

The library provides a simple Ruby interface to access the most common functionality:

```ruby
# This Ruby code:
Ghost::Download.youtube(url, sounde: true, quality: "best", pro: "#")

# Executes this command:
yt-dlp -f "bestvideo+bestaudio/best" --merge-output-format mp4 <url>
```

## Error Handling

The library provides specific error classes for different failure scenarios:

```ruby
begin
  Ghost::Download.youtube("https://invalid-url")
rescue Ghost::Errors::DownloadError => e
  puts "Download failed: #{e.message}"
end

begin
  Ghost::Caption.youtube("https://www.youtube.com/watch?v=ocV8fBuzeh8", language: "xx")
rescue Ghost::Errors::CaptionError => e
  puts "Caption download failed: #{e.message}"
end

begin
  Ghost::Cookies.youtube("https://www.youtube.com/watch?v=ocV8fBuzeh8", cookies_file: "/nonexistent/path")
rescue Ghost::Errors::CookiesError => e
  puts "Cookies download failed: #{e.message}"
end
```

## License

This project is licensed under the terms of the MIT license.# ghost_youtube
