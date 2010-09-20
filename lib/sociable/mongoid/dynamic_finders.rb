module Sociable
  module Mongoid
    module DynamicFinders

      def self.included(base)
        Sociable::Mongoid::DynamicFinders.constants.each do |klass|
          base.send(:include, "Sociable::Mongoid::DynamicFinders::#{klass.to_s}".constantize)
        end
      end

    end
  end
end
