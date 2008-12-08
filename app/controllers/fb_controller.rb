class FbController < ApplicationController
   ensure_authenticated_to_facebook   

    def index

      # authenticate

      @user = session[:facebook_session].user 

      # @friends = @user.friends

      # ALSO WORKING
      # session[:facebook_session].send_notification(@user.uid,"Woohoo") # works!

      # FBPublisher.register_publish_action(@user)
      # FBPublisher.deliver_publish_action(@user)

      # NOT WORKING



      # DEPRECATED
      # s = Facebooker::Feed::Story.new()
      #  s.title = "hey buster"
      #  session[:facebook_session].user.publish_story(s)

    end

    def view_profile

     @user = @facebook_session.user

    end


    def authenticate
       @facebook_session = Facebooker::Session.create(Facebooker.api_key, Facebooker.secret_key)
       session[:facebook_session] = @facebook_session
       redirect_to @facebook_session.login_url
     end

     def logout
       session[:facebook_session] = nil
       redirect_to "/"
       # Facebooker::Session = nil
     end


end
