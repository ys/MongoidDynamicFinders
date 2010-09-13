module Mongoid
  module FindOrCreateBy

    def self.included(base)
      base.class_eval <<-RUBY
        class << self
          alias_method :method_missing_bl4rg, :method_missing if methods.member? :method_missing
          def method_missing(method,*args)
            if (match = method.to_s.match /find_or_(create|initialize)_by_(.+)/) &&
               (match.size > 2)
              if result = where(match[2].to_sym => args[0]).first
                result
              else
                if match[1] == 'create'
                  create(match[2].to_sym => args[0])
                elsif match[1] == 'initialize'
                  new(match[2].to_sym => args[0])
                end
              end
            elsif methods.member? :method_missing_bl4rg
              send(:method_missing_bl4rg, method, *args)
            else
              super
            end
          end
        end
      RUBY
    end

  end
end
