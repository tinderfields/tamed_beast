# Include hook code here
ActiveRecord::Base.send :include, TamedBeast::ActiveRecord::Base   
ActionController::Base.helper(TamedBeast::ApplicationHelper)