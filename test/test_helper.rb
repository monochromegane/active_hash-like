$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_hash/like'
require 'active_hash'

ActiveHash::Base.prepend(ActiveHash::CustomMatchable)

require 'minitest/autorun'
