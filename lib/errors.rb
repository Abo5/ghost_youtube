# lib/errors.rb

module Ghost
    module Errors
        class YlpDlpNotFounde  < StandardError; end
        class UrlNotFounde < StandardError; end
        class BaseError < StandardError; end
        class DownloadError < BaseError; end
        class CaptionError < BaseError; end
        class CookiesError < BaseError; end
    end
end
  