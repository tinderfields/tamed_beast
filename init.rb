# Include hook code here

config.to_prepare do
  ApplicationController.helper(TamedBeast::Helpers::ApplicationHelper)
  ApplicationController.helper(TamedBeast::Helpers::ForumUsersHelper)
  ActiveRecord::Base.send :include, TamedBeast::ActiveRecord::Base
end
   
     

# FIX for engines model reloading issue in development mode
# A copy of ApplicationController has been removed from the module tree but is still active!
# A copy of TamedBeast::ActiveRecord::Base::ClassMethods has been removed from the module tree but is still active!
# 
load_paths.each do |path|
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end if ENV['RAILS_ENV'] != 'production' 
                                                         