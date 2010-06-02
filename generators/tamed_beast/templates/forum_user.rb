module ForumUser
  
  def self.included(base) 
     base.extend(ClassMethods)
     base.send(:include, InstanceMethods)
                         
     base.class_eval{
       has_many :posts
       has_many :topics  
     }     
     
   end  
    
    module ClassMethods
      # def active
      #    find_all_by_state('active')
      #    User.all
      # end   
    end
    
    module InstanceMethods  
      def seen!
        now = Time.now.utc
        self.class.update_all ['last_seen_at = ?', now], ['id = ?', id]
        write_attribute :last_seen_at, now
      end
      
      def active?
        true
      end
      
      def display_name
         login
      end
    end                                                          
   
end