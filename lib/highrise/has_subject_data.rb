module Highrise
  module HasSubjectData

    def subject_data_hash
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
    
    def set_field_value(field_name, value)
      cf = (attributes["subject_datas"] || []).detect do |sd|
        sd.subject_field_label == field_name.to_s
      end
      cf.value = value
      cf
    end
    
  end
end
