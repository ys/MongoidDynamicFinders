module Mongoid
  module DynamicFinders

    def self.included(base)
      base.send(:include, Mongoid::FindBy)
      base.send(:include, Mongoid::FindOrCreateBy)
    end

  end
end
