# Include hook code here
ActiveRecord::Base.send :include, TamedBeast::ActiveRecord::Base   
ActionController::Base.helper(TamedBeast::Helpers::ApplicationHelper) 
ActionController::Base.helper(TamedBeast::Helpers::ForumUsersHelper)       

# FIX for engines model reloading issue in development mode
# A copy of ApplicationController has been removed from the module tree but is still active!
# A copy of TamedBeast::ActiveRecord::Base::ClassMethods has been removed from the module tree but is still active!


load_paths.each do |path|
	ActiveSupport::Dependencies.load_once_paths.delete(path)
end if ENV['RAILS_ENV'] != 'production'                                                                                                                    