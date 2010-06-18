var TopicForm = {
  editNewTitle: function(txtField) {
    $('new_topic').innerHTML = (txtField.value.length > 5) ? txtField.value : 'New Topic';
  }
}

var LoginForm = {
  setToPassword: function() {
    $('openid_fields').hide();
    $('password_fields').show();
  },
  
  setToOpenID: function() {
    $('password_fields').hide();
    $('openid_fields').show();
  }
}

var PostForm = {
	postId: null,

	reply: Behavior.create({
		onclick:function() {
    	PostForm.cancel();
    	$('reply').toggle();
    	$('post_body').focus();
		}
	}),

	edit: Behavior.create(Remote.Link, {
		initialize: function($super, postId) {
			this.postId = postId;
			return $super();
		},
		onclick: function($super) {
			$('edit-post-' + this.postId + '_spinner').show();
			PostForm.clearPostId();
			return $super();
		}
	}),
	
	cancel: Behavior.create({
		onclick: function() { 
			PostForm.clearPostId(); 
			$('edit').hide()
			$('reply').hide()
			return false;
		}
	}),

  // sets the current post id we're editing
  editPost: function(postId) {
		this.postId = postId;
    $('post_' + postId + '-row').addClassName('editing');
		$('edit-post-' + postId + '_spinner').hide()
    if($('reply')) $('reply').hide();
		this.cancel.attach($('edit-cancel'))
		$('edit-form').observe('submit', function() { $('editbox_spinner').show() })
		setTimeout("$('edit_post_body').focus()", 250)
		// AddMoreButton.create();
		// Attachments.delete();
  },

  // checks whether we're editing this post already
  isEditing: function(postId) {
    if (PostForm.postId == postId.toString())
    {
      $('edit').show();
      $('edit_post_body').focus();
      return true;
    }
    return false;
  },

  clearPostId: function() {
    var currentId = PostForm.postId;
    if(!currentId) return;

    var row = $('post_' + currentId + '-row');
    if(row) row.removeClassName('editing');
		PostForm.postId = null;
  }
}

var RowManager = {
  addMouseBehavior : function(ele){
    ele.onmouseover = function(e){ 
      ele.addClassName('topic_over'); 
    }

    ele.onmouseout = function(e){
      ele.removeClassName('topic_over');
    }
  }
};


var AddMoreButton = Behavior.create({
	initialize: function(){
		$('files_button').update('<INPUT type="button" value="Add more" id="add_more_button">');
		//AddMoreButton.click.attach($("add_more_button"));
	},
	
		onclick: function(){
			console.log($$('.forum_attachments'));
			if($$('.forum_attachments').length < 5){
				$("browse_buttons").insert({"bottom":'<input type="file" name="forum_attachments[]" id="forum_attachments_" class="forum_attachments"><br />'});
			}
			else{
				$("add_more_button").disable();
			}
		}
});

function jordi(attachment_id){
	$$('.attachment-' + attachment_id)[0].remove();
	console.log($$("#attachments *"));
	if($$("#attachments *").first().getAttribute("class") == "comma") $$("#attachments *").first().remove();
	if($$("#attachments *").last().getAttribute("class") == "comma") $$("#attachments *").last().remove();
}


Event.addBehavior({
	'#search, #reply': function() { this.hide() },
	'#search-link:click': function() {
		$('search').toggle();
		$('search_box').focus();
		return false
	},
          
  'tr.forum' : function() {
    RowManager.addMouseBehavior(this);
  },
          
  'tr.topic' : function(){
    RowManager.addMouseBehavior(this);
  },

	'tr.post': function() {
		var postId = this.id.match(/^post_(\d+)-/)[1]
    var anchor = this.down(".edit a")
    if(anchor) { PostForm.edit.attach(anchor, postId) };
    RowManager.addMouseBehavior(this);
	},
	
	'#reply-link': function() {
		PostForm.reply.attach(this)
	},
	
	'#reply-cancel': function() {
		PostForm.cancel.attach(this)
	},
	
	'#files_button': AddMoreButton
	
});
Event.addBehavior.reassignAfterAjax = true; 
