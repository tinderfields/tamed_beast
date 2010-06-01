class TamedBeastGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "tamed_beast_tables"
    end
  end
end
