Rails::Generator::Commands::Create.class_eval do
  def gem_dependency(gem_name, command)
    logger.insert "Gem dependency: #{gem_name}"
    file = "config/environment.rb"
    
    gsub_file file, /^(Rails::Initializer.run do |config|) .+$/ do |match|
      "#{match}\n  #{command}"
    end
  end 
end 