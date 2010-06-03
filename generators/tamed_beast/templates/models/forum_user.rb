module ForumUser
  
  def self.included(base) 
     base.extend(ClassMethods)
     base.send(:include, InstanceMethods)
                         
     base.class_eval{
       
       formats_attributes :bio
       
       has_many :posts, :order => "#{Post.table_name}.created_at desc"
       has_many :topics, :order => "#{Topic.table_name}.created_at desc"

       has_many :moderatorships, :dependent => :delete_all
       has_many :forums, :through => :moderatorships, :source => :forum do
         def moderatable
           find :all, :select => "#{Forum.table_name}.*, #{Moderatorship.table_name}.id as moderatorship_id"
         end
       end

       has_many :monitorships, :dependent => :delete_all
       has_many :monitored_topics, :through => :monitorships, :source => :topic, :conditions => {"#{Monitorship.table_name}.active" => true}

       has_permalink :login

       attr_readonly :posts_count, :last_seen_at
       
       named_scope :active, :conditions => { :state => "active" }   
       
     }
     
   end  
    
    module ClassMethods
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
      
      alias_method :to_s, :display_name
      
      def to_param
        id.to_s # permalink || login
      end
    end                                                          
   
end