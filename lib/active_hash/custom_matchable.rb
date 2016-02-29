module ActiveHash
  module CustomMatchable
    def self.prepended(base)
      class << base
        self.prepend(ClassMethods)
      end
    end

    module ClassMethods
      def where(options)
        return @records if options.nil?
        (@records || []).select do |record|
          options.all? do |col, matcher|
            if matcher.respond_to?(:call)
              matcher.call(record[col])
            else
              record[col] == matcher
            end
          end
        end
      end
    end
  end
end
