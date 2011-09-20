module Highrise
  class Tag < Base  
    def ==(object)
      (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
    end
    
    def self.delete_by_name(name)
     tag = find_by_name(name)
     tag.destroy if tag
    end
  end
end
