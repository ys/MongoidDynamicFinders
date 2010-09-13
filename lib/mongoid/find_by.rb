module Mongoid
  module FindBy

    def self.included(base)
      base.class_eval <<-RUBY
        class << self
          if methods.member? :method_missing
            alias_method :method_missing_b00m, :method_missing
          end
          def method_missing(method,*args)
            if (match = method.to_s.match /find_by_(.+)/) && (match.size > 1)
              where(match[1].to_sym => args[0]).first
            elsif methods.member? :method_missing_b00m
              send(:method_missing_b00m, method, *args)
            else
              super
            end
          end
        end
      RUBY
    end

  end
end
