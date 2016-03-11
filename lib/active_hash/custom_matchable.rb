module ActiveHash
  module CustomMatchable
    def self.prepended(base)
      class << base
        self.prepend(ClassMethods)
      end
    end

    module ClassMethods

      def like(options)
        where(options.inject({}) do |likes, (column, pattern)|
          likes[column] = ActiveHash::Matcher::Like.new(pattern)
          likes
        end)
      end

      def where(options)
        return @records if options.nil?
        (@records || []).select do |record|
          options.all? do |col, matcher|
            if matcher.respond_to?(:call)
              matcher.call(record[col])
            elsif col.to_sym == :or
              ActiveHash::Matcher::Or.new(matcher).call(record)
            else
              record[col] == matcher
            end
          end
        end
      end
    end
  end
end
