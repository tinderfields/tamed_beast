module TamedBeast
  module ActiveRecord   
    module Base   
      def self.included(base) 
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
      
        class << base
          cattr_accessor :white_list_sanitizer     
          self.white_list_sanitizer = HTML::WhiteListSanitizer.new
          attr_accessor :formatted_attributes
        end
          
      end
  
      module ClassMethods
        def concerned_with(*concerns)
          concerns.each do |concern|
            require_dependency "#{name.underscore}/#{concern}"
          end
        end
    
        def formats_attributes(*attributes)
          (self.formatted_attributes ||= []).push *attributes
          before_save :format_attributes
          send :include, HtmlFormatting, ActionView::Helpers::TagHelper, ActionView::Helpers::TextHelper
        end

        def paginated_each(options = {}, &block)
          page = 1
          records = [nil]
          until records.empty? do 
            records = paginate(options.update(:page => page, :count => {:select => '*'}))
            records.each &block
            page += 1
          end
        end
      end
  
      module InstanceMethods
      end  
    end
  end
end