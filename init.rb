# Include hook code here
ActiveRecord::Base.send :include, TamedBeast::ActiveRecord::Base   
ActionController::Base.helper(TamedBeast::ApplicationHelper)       

# FIX for engines model reloading issue in development mode
if ENV['RAILS_ENV'] != 'production'
	load_paths.each do |path|
		ActiveSupport::Dependencies.load_once_paths.delete(path)
	end
end