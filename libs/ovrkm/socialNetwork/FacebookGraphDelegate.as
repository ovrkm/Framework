package ovrkm.socialNetwork
{
	import com.facebook.graph.Facebook;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;

	import flash.utils.ByteArray;

	import ovrkm.socialNetwork.vo.UserVO;
	import ovrkm.utils.Callback;

	import sk.yoz.events.FacebookOAuthGraphEvent;
    import sk.yoz.net.FacebookOAuthGraph;

	public class FacebookGraphDelegate implements ISocialNetworkDelegate
	{
		// path to our callback
		private var redirectURI:String =
			"http://eve.dev.promodev.ru/callback.html";

		// required extended permissions
		private var scope:String = "publish_stream,user_photos,user_photo_video_tags";

		private var parameters:Object;

		function FacebookGraphDelegate(parameters:Object, clientID:String)
		{
			this.parameters = parameters;

			Facebook.init(clientID, onInit);


		}

		private function onInit(result:Object, fail:Object):void
		{
			trace(result, fail);
		}

		////////////////////////////////////////

		public function postResult(id:String, message:String):void
		{

		}

		public function getFriends():void
		{

		}

		public function navigateToUser(id:String):void
		{

		}

		public function showInviteBox():void
		{

		}

		public function getUserInfo(id:String):void
		{

		}

		public function getURL(url:String):void
		{

		}

		public function getViewer():void
		{

		}
	}
}