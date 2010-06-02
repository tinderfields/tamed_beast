class TamedBeastGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "tamed_beast_tables"
      m.directory "app/views/layouts"
      m.template  "views/layouts/tamed_beast.html.erb", "app/views/layouts/tamed_beast.html.erb"
      m.template  "views/layouts/_tb_head.html.erb", "app/views/layouts/_tb_head.html.erb"
      m.template  "tamed_beast.css", "public/stylesheets/tamed_beast.css"
      `cp -rf vendor/plugins/tamed_beast/vendor/plugins/* vendor/plugins/`
      m.directory "public/images"
      `cp -rf vendor/plugins/tamed_beast/public/images/* public/images`
      m.template "forum_user.rb" "app/models/forum_user.rb"
    end
  end
end
