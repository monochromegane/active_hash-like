module ActiveHash
  module Like
    class Railtie < Rails::Railtie
      initializer 'prepend_active_hash-custom_matchable-module' do
        ActiveHash::Base.prepend(ActiveHash::CustomMatchable)
      end
    end
  end
end
