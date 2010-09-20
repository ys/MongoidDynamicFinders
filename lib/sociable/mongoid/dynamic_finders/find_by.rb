module Sociable
  module Mongoid
    module DynamicFinders
      module FindBy

        def self.included(base)
          base.class_eval do
            class << self
              old_method_missing = if methods(false).member? :method_missing
                                     method(:method_missing)
                                   end
              define_method :method_missing do |method,*args|
                if (match = method.to_s.match /^find_(all_by|first_by|last_by|by)_([a-zA-Z_]+)$/)
                 tokens =  match[2].split('_and_')
                 raise ArgumentError, "number of attributes and arguments don't match (#{tokens.size} and #{args.size})." if tokens.size != args.size
                 query = {}
                 tokens.size.times do |i|
                   query[tokens[i].to_sym] = args[i]
                 end
                 case match[1]
                 when "all_by"
                   where(query)
                 when "last_by"
                   where(query).last
                 else
                   where(query).first
                 end
                elsif old_method_missing
                  old_method_missing.bind(self).call
                else 
                  super(method, *args)
                end
              end
            end
          end
        end

      end
    end
  end
end
