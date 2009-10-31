module Imbue
  def imbue m
    include m
    # now that self includes m, find classes that previously
    # included self and include it again, so as to cause them
    # to also include m
    ObjectSpace.each_object(Class) do |k|
      k.send :include, self if k.include? self
    end
  end
end

class Module
  include Imbue
end
