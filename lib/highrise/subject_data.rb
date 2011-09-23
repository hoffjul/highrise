module Highrise
  class SubjectData < Base
    
    module Mixin
  
      def subject_data_fields
        if attributes.has_key?(:subject_datas)
          Hash[subject_datas.map(&:attributes).map {|attrs| [attrs[:subject_field_label].to_s.underscore, attrs[:value]] }]
        else
          {}
        end
      end

      def field(field_name)
        (attributes["subject_datas"] || []).detect do |sd|
          sd.subject_field_label == field_name.to_s
        end
      end
      
    end

  end
end
