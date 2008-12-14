class FbController < ApplicationController
  #ensure_application_is_installed_by_facebook_user
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
        
     def link

       # verify user sig

       api_key = Facebooker.api_key + '_'

       # get all the facebook cookies
       fbcookies = cookies.select{|k,v| k.index(api_key) == 0}

       string = ""
       fbcookies.sort.each{|a| string += "#{a.first.gsub(/\A#{api_key}/, "")}=#{a.last.first}"}

       reportedsig = cookies[Facebooker.api_key]

       generatedsig = Digest::MD5.hexdigest(string + Facebooker.secret_key)

       unless reportedsig == generatedsig
         render_404
         return false
       end

       uid = cookies[api_key + "user"]

       if @session_user.fb_uid.blank? || @session_user.fb_uid != uid
         @session_user.fb_uid = uid
         @session_user.save
       end

       redirect_to root_url
      end


end
