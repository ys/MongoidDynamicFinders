require File.join(File.dirname(__FILE__), 'lib', 'sociable', 'mongoid', 'dynamic_finders')
module ::Mongoid
  DynamicFinders = Sociable::Mongoid::DynamicFinders
end

Dir.entries(File.join(File.dirname(__FILE__), 'lib', 'sociable', 'mongoid', 'dynamic_finders')).each do |file|
  if file =~ /.*\.rb$/
    require File.join(File.dirname(__FILE__), 'lib', 'sociable', 'mongoid', 'dynamic_finders', file)
    klass = begin
              "sociable/mongoid/dynamic_finders/#{file.gsub(/\.rb$/, '')}".camelize.constantize
            rescue NameError
              nil
            end
    if klass
      ::Mongoid.const_set(klass.to_s.demodulize, klass)
    end
  end
end
