require "active_hash/like/version"
require "active_hash/custom_matchable"
require "active_hash/matcher/like"
require "active_hash/matcher/or"

require "active_hash/like/railtie" if defined?(Rails::Railtie)

module ActiveHash
  module Like
  end
end
