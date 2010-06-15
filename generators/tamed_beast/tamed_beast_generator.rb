require File.expand_path(File.dirname(__FILE__) + "/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/file_commands.rb")  

class TamedBeastGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Controllers
      m.files_from_dir "controllers", "app/controllers/tamed_beast"
      
      # Models
      m.file  "models/forum_user.rb", "app/models/forum_user.rb"
      
      # Views
      m.files_from_dir "views", "app/views"
      
      # Migrations
      m.migration_template "migrations/migration.rb", "db/migrate", :migration_file_name => "tamed_beast_tables"
      
      # Javascripts
      m.files_from_dir "javascripts", "public/javascripts"
      
      # Plugins
      m.files_from_dir "plugins", "vendor/plugins" 
      
      # Stylesheets
      m.file  "stylesheets/tamed_beast.css", "public/stylesheets/tamed_beast.css"
      
      # Images
      m.files_from_dir "images", "public/images"
      
      # Gem dependencies
      m.gem_dependency "RedCloth", "config.gem 'RedCloth', :lib => 'redcloth'"
      m.gem_dependency "bluecloth", "config.gem 'bluecloth'"
      m.gem_dependency "mislav-will_paginate", "config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'"
      
      # Include in User model
      m.model_include "user.rb", "ForumUser"                               

    end
  end
end
