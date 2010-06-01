# Include hook code here
ActiveRecord::Base.send :include, TamedBeast::ActiveRecord::Base   
ActiveController::Base.helper(TamedBeast::ApplicationHelper)

`cp -rf vendor/plugins/tamed_beast/vendor/plugins/* vendor/plugins/`