module Highrise
  class Person < Subject
    include Pagination
    include Taggable
    include Searchable
    include HasSubjectData
    
    def company
      Company.find(company_id) if company_id
    end
  
    def name
      "#{first_name rescue ''} #{last_name rescue ''}".strip
    end
    
    def address
      contact_data.addresses.first
    end
    
    def web_address
      contact_data.web_addresses.first
    end
    
    def label
      'Party'
    end
    
    def phone_number
      contact_data.phone_numbers.first.number rescue nil
    end
    
    def email_valid?
      !!(email_address && (email_address =~ RFC822::EmailAddress))
    end
    
    def email_address
      contact_data.email_addresses.first.address rescue nil
    end
    alias :email :email_address
    
    def tagged? name
     tags.any?{ | tag | tag['name'].to_s == name}  
    end
    
    def self.tagged_with_name(tag_name)
      tagged_with_id((Tag.find_by_name(tag_name)).id)
    end
    
    def self.tagged_with_id id
     find_all_across_pages(:from => "/tags/#{id}.xml").select do |obj|
        obj.kind_of?(Person)
      end
    end
    
  end
end
