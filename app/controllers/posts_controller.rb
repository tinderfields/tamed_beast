class PostsController < TamedBeastController
  before_filter :find_parents
  before_filter :find_post, :only => [:edit, :update, :destroy]

  # /posts
  # /users/1/posts
  # /forums/1/posts
  # /forums/1/topics/1/posts
  def index
    @posts = (@parent ? @parent.posts : Post).search(params[:q], :page => current_page)
    @users = @user ? {@user.id => @user} : User.index_from(@posts)
    respond_to do |format|
      format.html # index.html.erb
      format.atom # index.atom.builder
      format.xml  { render :xml  => @posts }
    end
  end

  def show
    respond_to do |format|
      format.html { redirect_to forum_topic_path(@forum, @topic) }
      format.xml  do
        find_post
        render :xml  => @post
      end
    end
  end

  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js
    end
  end


  def create
    # @post = current_user.reply @topic, params[:post][:body] 
    @post = @current_user.posts.build(:body => params[:post][:body])
    @post.topic = @topic
    @post.forum = @topic.forum
    @post.forum_attachments << ForumAttachment.generate(params[:forum_attachments]) if params[:forum_attachments]

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(forum_topic_post_path(@forum, @topic, @post, :anchor => dom_id(@post))) }
        format.xml  { render :xml  => @post, :status => :created, :location => forum_topic_post_url(@forum, @topic, @post) }        
      else
        format.html { redirect_to forum_topic_path(@forum, @topic) }
        format.xml  { render :xml  => @post.errors, :status => :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @post.new_record?
    #     format.html { redirect_to forum_topic_path(@forum, @topic) }
    #     format.xml  { render :xml  => @post.errors, :status => :unprocessable_entity }
    #   else
    #     flash[:notice] = 'Post was successfully created.'
    #     format.html { redirect_to(forum_topic_post_path(@forum, @topic, @post, :anchor => dom_id(@post))) }
    #     format.xml  { render :xml  => @post, :status => :created, :location => forum_topic_post_url(@forum, @topic, @post) }
    #   end
    # end  


  end

  def update
    
    @post.forum_attachments << ForumAttachment.generate(params[:forum_attachments]) if params[:forum_attachments]
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(forum_topic_path(@forum, @topic, :anchor => dom_id(@post))) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml  => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topic_path(@forum, @topic)) }
      format.xml  { head :ok }
    end
  end

protected
  def find_parents
    if params[:forum_user_id]
      @parent = @user = User.find(params[:forum_user_id])
    elsif params[:forum_id]
      @parent = @forum = Forum.find_by_permalink(params[:forum_id])
      @parent = @topic = @forum.topics.find_by_permalink(params[:topic_id]) if params[:topic_id]
    end
  end

  def find_post
    post = @topic.posts.find(params[:id])
    if post.user == current_user || current_user.forum_admin?
      @post = post
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end