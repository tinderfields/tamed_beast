class ForumAttachment < ActiveRecord::Base
  belongs_to :post
  
  has_attached_file :file
  
  def self.generate(forum_attachments)
    forum_attachments.select{ |fa| !fa.nil? }.map{ |fa| ForumAttachment.new(:file => fa) }
  end
      
end
