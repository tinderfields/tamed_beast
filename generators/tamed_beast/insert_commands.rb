Rails::Generator::Commands::Create.class_eval do
  def gem_dependency(gem_name, command)
    logger.insert "Gem dependency: #{gem_name}"
    file = "config/environment.rb"
    
    gsub_file file, "Rails::Initializer.run do |config|" do |match|
      "#{match}\n  #{command}"
    end
  end
  
  def reload_plugins
    logger.insert "Environment: config.reload_plugins = true if RAILS_ENV == 'development' "
    file = "config/environment.rb"
    
    gsub_file file, "Rails::Initializer.run do |config|" do |match|
      "#{match}\n  config.reload_plugins = true if RAILS_ENV == 'development'"
    end
  end
  
  def model_include(model_name, include_name)
    insert_into("app/models/#{model_name}", "include #{include_name}")
  end
  
  def insert_into(file, line)
    logger.insert "#{line} into #{file}"
    unless options[:pretend]
      gsub_file file, /^(class|module) .+$/ do |match|
        "#{match}\n  #{line}"
      end
    end
  end
     
end 