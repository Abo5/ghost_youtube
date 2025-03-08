# ghost_youtube.gemspec
Gem::Specification.new do |spec|
    spec.name          = "ghost_youtube"
    spec.version       = "0.1.1"
    spec.authors       = ["Maven"]
  
    spec.summary       = %q{A Ruby library to download YouTube videos with audio and captions of Videos}
    spec.description   = %q{
      GhostYoutube is a pure Ruby gem that wraps the command-line tool, making it
      easy to download YouTube videos, captions, and videos using cookies. It is designed
      to be used in any Ruby environment (Ruby, Rails, JRuby, CRuby, etc.).
    }
    spec.homepage      = "https://github.com/Abo5/ghost_youtube"
    spec.license       = "MIT"
  
    spec.required_ruby_version = ">= 2.5.0"
  
    spec.files         = Dir["lib/**/*", "ghost_youtube.rb", "README.md", "LICENSE", "Gemfile", "ghost_youtube.gemspec"]
    spec.executables   = []
    spec.require_paths = ["lib"]
  
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  end
  
