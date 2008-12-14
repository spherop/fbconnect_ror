

FB_RequireFeatures(["XFBML"], function()
{
    FB.Facebook.init(window.api_key, window.xd_receiver_location);
    FB.Facebook.get_sessionState().waitUntilReady(
	function() { // CALLBACK
	 // call our def link and connects this session 
	
		//$.post("/fb_controller/link_sessions", , null, "script");
		alert("FBConnect Session Key: " + FB.Facebook.apiClient.get_session().session_key);
		
	
 } );
});
