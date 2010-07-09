class User
  # Creates new topic and post.
  # Only..
  #  - sets sticky/locked bits if you're a moderator or forum_admin 
  #  - changes forum_id if you're an forum_admin
  #
  # def post(forum, attributes)
  #   attributes.symbolize_keys!
  #   Topic.new(attributes) do |topic|
  #     topic.forum = forum
  #     topic.user  = self
  #     revise_topic topic, attributes, moderator_of?(forum)
  #   end
  # end        

  # def reply(topic, body)
  #   returning topic.posts.build(:body => body) do |post|
  #     post.forum = topic.forum
  #     post.user  = self
  #     post.save
  #   end
  # end   
  
 
end