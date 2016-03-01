module ActiveHash::Matcher
  class Like
    class << self
      def forward(pattern)
        new("#{pattern}%")
      end

      def backward(pattern)
        new("%#{pattern}")
      end

      def partial(pattern)
        new("%#{pattern}%")
      end
    end

    attr_accessor :pattern, :match_type

    def initialize(pattern)
      pattern = pattern.to_s
      self.pattern = pattern.gsub(/\A%|%\Z/, '')

      self.match_type = case pattern
                        when /\A%.*%\Z/ then :partial
                        when /\A%/      then :backward
                        when /%\Z/      then :forward
                        else                 :none
                        end
    end

    def call(value)
      match(value.to_s.upcase, pattern.upcase)
    end

    private

    def match(value, pattern)
      case match_type
      when :forward  then value.start_with?(pattern)
      when :backward then value.end_with?(pattern)
      when :partial  then value.include?(pattern)
      else                value == pattern
      end
    end
  end
end
