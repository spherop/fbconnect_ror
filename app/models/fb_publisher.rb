class FBPublisher < Facebooker::Rails::Publisher
  # Action is published using the session of the from user
   # more info http://facebooker.rubyforge.org/classes/Facebooker/Rails/Publisher.html
       def action(f)
         send_as :action
         from f
         title "Action Title"
         body "Body FBML here #{fb_name(f)} #{link_to "text","http://url"}"
       end

       # The new message templates are supported as well
       # First, create a method that contains your templates:
       # You may include multiple one line story templates and short story templates
       # but only one full story template
       #  Your most specific template should be first
       #
       # Before using, you must register your template by calling register. For this example
       #  You would call TestPublisher.register_publish_action
       #  Registering the template will store the template id returned from Facebook in the
       # facebook_templates table that is created when you create your first publisher
       def publish_action_template
         one_line_story_template "{*actor*} knows and cannot believe the principles and foundational aspect of {*friend*}"
         one_line_story_template "{*actor*} did stuff"
         short_story_template "{*actor*} has a title {*friend*}", render(:partial=>"short_body")
         short_story_template "{*actor*} has a title", render(:partial=>"short_body")
         full_story_template "{*actor*} has a title {*friend*}", render(:partial=>"full_body")
         action_links action_link("from {*template_var*}","{*link_url*}")
       end

       # To send a registered template, you need to create a method to set the data
       # The publisher will look up the template id from the facebook_templates table
       def publish_action(f)
         send_as :user_action
         from f
         data :friend=>"name_of_friend", :template_var => "it's cool", :link_url => "http://www.rareseen.com",
          :images => [{:src => "http://pad.thedigitalmovement.com/_blaise/2007-06-15-dgen-breakfast.jpg", :href => "http://www.facebook.com"}],
          :youtube_id => "DvBlICAzxJw"
       end

       # Provide a from user to send a general notification
       # if from is nil, this will send an announcement
       def notification(to,f)
         send_as :notification
         recipients to
         from f
         fbml "Not"
       end

       def email(to,f)
         send_as :email
         recipients to
         from f
         title "Email"
         fbml 'text'
         text fbml
       end
       # This will render the profile in /users/profile.erb
       #   it will set @user to user_to_update in the template
       #  The mobile profile will be rendered from the app/views/test_publisher/_mobile.erb
       #   template
       def profile_update(user_to_update,user_with_session_to_use)
         send_as :profile
         from user_with_session_to_use
         to user_to_update
         profile render(:action=>"/users/profile",:assigns=>{:user=>user_to_update})
         profile_action "A string"
         mobile_profile render(:partial=>"mobile",:assigns=>{:user=>user_to_update})
     end

       #  Update the given handle ref with the content from a
       #   template
       def ref_update(user)
         send_as :ref
         from user
         fbml render(:action=>"/users/profile",:assigns=>{:user=>user_to_update})
         handle "a_ref_handle"
     end
end
