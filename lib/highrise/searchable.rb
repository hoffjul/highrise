module Highrise
  module Searchable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # List By Search Criteria
      # Ex: Highrise::Person.search(:email => "john.doe@example.com", :country => "CA")
      # Available criteria are: city, state, country, zip, phone, email
      def search(options = {})
        raise ArgumentError, "cannot convert #{options}:#{options.class} to hash" if options.kind_of?(String)
        # This might have to be changed in the future if other non-pagable resources become searchable
        options[:kind] ||= collection_name
        find_options = {:from => "/parties/search.xml", :params => options}
        if respond_to?(:find_all_across_pages)
          find_all_across_pages(find_options)
        else
          find(:all, find_options)
        end
      end
    end
  end
end
