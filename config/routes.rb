ActionController::Routing::Routes.draw do |map|
  # map.open_id_complete '/session', 
  #   :controller => "sessions", :action => "create",
  #   :requirements => { :method => :get }   


  map.namespace :tamed_beast, :path_prefix => '', :name_prefix => '' do |tamed_beast|
    tamed_beast.resources :moderatorships, :monitorship
  

    tamed_beast.resources :forums, :has_many => :posts do |forum|
      forum.resources :topics do |topic|
        topic.resources :posts
        topic.resource :monitorship
      end
      forum.resources :posts
    end
  
  
    tamed_beast.resources :posts, :collection => {:search => :get}
    tamed_beast.resources :forum_users, :member => { :suspend   => :put,
                                       :settings  => :get,
                                       :make_admin => :put,
                                       :unsuspend => :put,
                                       :purge     => :delete },
                          :has_many => [:posts]  
    # 
    # map.activate '/activate/:activation_code', :controller => 'users',    :action => 'activate', :activation_code => nil
    # map.signup   '/signup',                    :controller => 'users',    :action => 'new'
    # map.login    '/login',                     :controller => 'sessions', :action => 'new'
    # map.logout   '/logout',                    :controller => 'sessions', :action => 'destroy'
    tamed_beast.settings '/settings',                  :controller => 'forum_users',    :action => 'settings'
    # map.resource  :session                                                                  
  
    tamed_beast.with_options :controller => 'posts', :action => 'monitored' do |map|
      map.formatted_monitored_posts 'users/:user_id/monitored.:format'
      map.monitored_posts           'users/:user_id/monitored'
    end
    tamed_beast.resources :forum_attachments          
  end

  # map.root :controller => 'forums', :action => 'index'
end
