module Highrise
  class Person < Subject
    require 'highrise/rfc822'
    include Pagination
    include Taggable
    include Searchable
    include SubjectData::Mixin
    
    def initialize(*args)
      super(*args)
      create_subject_fields_accessors
    end 
    
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
    alias :tagged_with_name :tagged?
    
    def create_subject_fields_accessors  
      subject_data_fields.each do |subject_field_name, value|
        # for this instance only
        singleton_class.instance_eval do
          define_method subject_field_name do
            value 
          end
        end
      end
    end
    
  end
end
