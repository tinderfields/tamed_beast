class TamedBeastGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "tamed_beast_tables"
      `cp -rf vendor/plugins/tamed_beast/vendor/plugins/* vendor/plugins/`
    end
  end
end
