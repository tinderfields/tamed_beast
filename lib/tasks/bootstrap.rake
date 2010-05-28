namespace :app do
  task :app_specific => [:create_site] do
  end

  task :create_site => [:setup, :environment] do
    say "We need to create a default 'site' for your users to blog and forum and whatnot."
    say "Or for you to test on, if you're a developer."
    say "If you are a developer, and you set the host to anything other than 'localhost', please make sure to add an entry to your /etc/hosts file, f.e.: '127.0.0.1 test.local'"
    
    options = OpenStruct.new :login => 'admin', :password => nil, :email => 'admin@example.com'
    say "Time to create your administrator account."
    options.login = ask('Login:') {|q| q.default = options.login }
    options.password = ask('Password:') {|q| q.echo = '*' }
    options.email = ask('Email:') {|q| q.default = options.email }
    
    user = User.new :login => options.login, :email => options.email
    user.admin = true
    user.password = user.password_confirmation = options.password
    begin
      user.save!
    rescue ActiveRecord::RecordInvalid
      say "The user didn't validate for whatever reason. Fix and call user.save!"
      say user.errors.full_messages.to_sentence
      debugger
    end
    user.activate!
    say "User created successfully"
    say user.inspect
    puts
  end
  
end