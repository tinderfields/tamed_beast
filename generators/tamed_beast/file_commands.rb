Rails::Generator::Commands::Create.class_eval do
  
  def files_from_dir(dir_from, dir_to)
    pwd, relative_path = Dir.pwd, source_path(dir_from)
    Dir.chdir relative_path
    directory  dir_to
    Dir["**/*"].each do |path|     
      File.directory?(path) ? (directory "#{dir_to}/#{path}") : (file "#{dir_from}/#{path}", "#{dir_to}/#{path}")     
    end
    Dir.chdir pwd    
  end
  
  def templates_from_dir(dir_from, dir_to)
    pwd, relative_path = Dir.pwd, source_path(dir_from)
    Dir.chdir relative_path
    directory  dir_to
    Dir["**/*"].each do |path|     
      File.directory?(path) ? (directory "#{dir_to}/#{path}") : (template "#{dir_from}/#{path}", "#{dir_to}/#{path}")
    end     
    Dir.chdir pwd    
  end
  
end