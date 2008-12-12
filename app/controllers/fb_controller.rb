class FbController < ApplicationController
  ensure_application_is_installed_by_facebook_user
  ensure_authenticated_to_facebook   

    def index
  
      @user = session[:facebook_session].user 
      @friends = @user.friends

      # ALSO WORKING
      # session[:facebook_session].send_notification(@user.uid,"Woohoo") # works!

      # FBPublisher.register_publish_action(@user)
      # FBPublisher.deliver_publish_action(@user)

      # DEPRECATED
      # s = Facebooker::Feed::Story.new()
      #  s.title = "hey buster"
      #  session[:facebook_session].user.publish_story(s)

    end

         
        def authenticate
           @facebook_session = Facebooker::Session.create(Facebooker.api_key, Facebooker.secret_key)
           session[:facebook_session] = @facebook_session
           redirect_to @facebook_session.login_url
         end
        
  


end
