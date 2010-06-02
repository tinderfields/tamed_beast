require File.expand_path(File.dirname(__FILE__) + "/insert_commands.rb")

class TamedBeastGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Models
      m.template  "models/forum_user.rb", "app/models/forum_user.rb"

      # Migrations
      m.migration_template "migrations/migration.rb", "db/migrate", :migration_file_name => "tamed_beast_tables"
      
      # Layouts
      m.directory "app/views/layouts"
      m.template  "views/layouts/tamed_beast.html.erb", "app/views/layouts/tamed_beast.html.erb"
      m.template  "views/layouts/_tb_head.html.erb", "app/views/layouts/_tb_head.html.erb"
      
      # Javascripts
      m.directory "public/javascripts"
      m.template  "javascripts/tamed_beast.js", "public/javascripts/tamed_beast.js"
      m.template  "javascripts/controls.js", "public/javascripts/controls.js"
      m.template  "javascripts/dragdrop.js", "public/javascripts/dragdrop.js"
      m.template  "javascripts/effects.js", "public/javascripts/effects.js"
      m.template  "javascripts/lowpro.js", "public/javascripts/lowpro.js"
      m.template  "javascripts/prototype.js", "public/javascripts/prototype.js"
      
      # Plugins
      `cp -rf vendor/plugins/tamed_beast/vendor/plugins/* vendor/plugins/`
      
      # Stylesheets
      m.template  "stylesheets/tamed_beast.css", "public/stylesheets/tamed_beast.css"

      # Images
      m.directory "public/images"
      `cp -rf vendor/plugins/tamed_beast/public/images/* public/images`
      
      # Gem dependencies
      m.gem_dependency "RedCloth", "config.gem 'RedCloth', :lib => 'redcloth'"
      m.gem_dependency "bluecloth", "config.gem 'bluecloth'"
      m.gem_dependency "mislav-will_paginate", "config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'"

    end
  end
end
