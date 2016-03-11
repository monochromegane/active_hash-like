module ActiveHash::Matcher
  class Or
    attr_accessor :patterns

    def initialize(patterns)
      self.patterns = patterns
    end

    def call(record)
      patterns.any? do |col, matcher|
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

