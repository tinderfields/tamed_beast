class ForumAttachment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :stars
  
  before_create :set_user, :if => :post_id
  
  has_attached_file :file
  
  def self.generate(forum_attachments)
    forum_attachments.select{ |fa| !fa.nil? }.map{ |fa| ForumAttachment.new(:file => fa) }
  end
  
  def name
    file_file_name
  end
  
  def url
    file.url
  end
  
  def topic
    post.topic
  end
  
  def forum
    post.forum
  end
  
  def file_type
    File.extname(name).gsub!('.','')
  end
  
  protected
  
  def set_user            
    self.user_id = self.post.user_id
  end
      
end
