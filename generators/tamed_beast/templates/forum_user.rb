module ForumUser
  
   has_many :posts
   has_many :forums
   
   def seen!
     now = Time.now.utc
     self.class.update_all ['last_seen_at = ?', now], ['id = ?', id]
     write_attribute :last_seen_at, now
   end
   
end