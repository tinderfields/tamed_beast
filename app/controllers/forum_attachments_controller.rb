class ForumAttachmentsController < TamedBeastController
  # GET /forum_attachments
  # GET /forum_attachments.xml
  def index
    @forum_attachments = ForumAttachment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_attachments }
    end
  end

  # GET /forum_attachments/1
  # GET /forum_attachments/1.xml
  def show
    @forum_attachment = ForumAttachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_attachment }
    end
  end

  # GET /forum_attachments/new
  # GET /forum_attachments/new.xml
  def new
    @forum_attachment = ForumAttachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_attachment }
    end
  end

  # GET /forum_attachments/1/edit
  def edit
    @forum_attachment = ForumAttachment.find(params[:id])
  end

  # POST /forum_attachments
  # POST /forum_attachments.xml
  def create
    @forum_attachment = ForumAttachment.new(params[:forum_attachment])

    respond_to do |format|
      if @forum_attachment.save
        flash[:notice] = 'ForumAttachment was successfully created.'
        format.html { redirect_to(@forum_attachment) }
        format.xml  { render :xml => @forum_attachment, :status => :created, :location => @forum_attachment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_attachments/1
  # PUT /forum_attachments/1.xml
  def update
    @forum_attachment = ForumAttachment.find(params[:id])

    respond_to do |format|
      if @forum_attachment.update_attributes(params[:forum_attachment])
        flash[:notice] = 'ForumAttachment was successfully updated.'
        format.html { redirect_to(@forum_attachment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_attachments/1
  # DELETE /forum_attachments/1.xml
  def destroy
    @forum_attachment = ForumAttachment.find(params[:id])
    @forum_attachment.destroy

    respond_to do |format|
      format.html { redirect_to(forum_attachments_url) }
      format.xml  { head :ok }
    end
  end
end
