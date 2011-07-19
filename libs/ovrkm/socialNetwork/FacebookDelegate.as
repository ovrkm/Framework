package ovrkm.socialNetwork
{
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.commands.stream.PublishPost;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.commands.users.HasAppPermission;
	import com.facebook.data.BooleanResultData;
	import com.facebook.data.auth.ExtendedPermissionValues;
	import com.facebook.data.friends.GetFriendsData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetInfoFieldValues;
	import com.facebook.data.users.HasAppPermissionValues;
	import com.facebook.events.FacebookEvent;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookSessionUtil;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import ovrkm.socialNetwork.vo.UserVO;
	import ovrkm.utils.Callback;

	public class FacebookDelegate implements ISocialNetworkDelegate
	{
		private var callback:Callback;
		private var _facebookSession:FacebookSessionUtil;
		
		public function FacebookDelegate(client:Object, callback:Callback)
		{
			this.callback = callback;
			
			_facebookSession = client as FacebookSessionUtil;
		}
		
		//
		
		private var _id:String;
		private var _message:String;
		
		public function postResult(id:String, message:String):void
		{
			_id = id;
			_message = message;
			
			checkPermissions();
		}
		
		protected function checkPermissions():void {
			var call:HasAppPermission = new HasAppPermission(HasAppPermissionValues.PUBLISH_STREAM);
			call.addEventListener(FacebookEvent.COMPLETE, onPermissionDisclosed);
			_facebookSession.facebook.post(call);
		}
		
		protected function onPermissionDisclosed(e:FacebookEvent):void {
			if (e.success && ((e.data as BooleanResultData).value)) doPublish();
			else _facebookSession.facebook.grantExtendedPermission(ExtendedPermissionValues.PUBLISH_STREAM);
		}
		
		protected function doPublish():void
		{
			var post:PublishPost = new PublishPost(_message, null, null, _id);
			var call:FacebookCall = _facebookSession.facebook.post(post);
			call.addEventListener(FacebookEvent.COMPLETE, handle_publishPostComplete);			
		}
		
		private function handle_publishPostComplete(event:FacebookEvent):void
		{
			navigateToUser(_id);
		}
		
		//
		
		public function getFriends():void
		{
			var call:FacebookCall = _facebookSession.facebook.post(new GetFriends("", _facebookSession.facebook.uid));
			call.addEventListener(FacebookEvent.COMPLETE, _handle_getFriendsComplete);
		}
		
		private function _handle_getFriendsComplete(event:FacebookEvent):void
		{
			var data:GetFriendsData = GetFriendsData(event.data);
			var uids:Array = [];
			
			for each(var friend:FacebookUser in data.friends.source)
				uids.push(friend.uid);
			
			var call:FacebookCall = _facebookSession.facebook.post(new GetInfo(uids, 
				[
					GetInfoFieldValues.FIRST_NAME,
					GetInfoFieldValues.LAST_NAME,
					GetInfoFieldValues.PIC_SQUARE
				]));
			call.addEventListener(FacebookEvent.COMPLETE, _handle_getFriendsInfoComplete);
		}
		
		private function _handle_getFriendsInfoComplete(event:FacebookEvent):void
		{
			var getInfoData:GetInfoData = GetInfoData(event.data);
			var uvos:Array = new Array();
			var uvo:UserVO;
			
			for each(var facebookUser:FacebookUser in getInfoData.userCollection.source)
			{
				uvo = new UserVO();
				uvo.uid = facebookUser.uid;
				uvo.nickname = "";
				uvo.firstName = facebookUser.first_name ? facebookUser.first_name : "";
				uvo.lastName = facebookUser.last_name ? facebookUser.last_name : "";
				uvo.photoSmall = facebookUser.pic_square;
				
				uvos.push(uvo);
			}
			
			callback.onResult(uvos);
		}
		
		//
		
		public function navigateToUser(id:String):void
		{
			navigateToURL(new URLRequest("http://www.com.facebook.com/profile.php?id="+ id), "_blank");
		}
		
		//
		
		public function showInviteBox():void
		{
			//!!
		}
		
		//
		
		public function getUserInfo(id:String):void
		{
			var values:Array = [
				GetInfoFieldValues.FIRST_NAME, 
				GetInfoFieldValues.LAST_NAME, 
				GetInfoFieldValues.PIC_BIG, 
				GetInfoFieldValues.SEX, 
				GetInfoFieldValues.CURRENT_LOCATION, 
				GetInfoFieldValues.BIRTHDAY
			];
			
			var call:FacebookCall = _facebookSession.facebook.post(new GetInfo([id], values));
			call.addEventListener(FacebookEvent.COMPLETE, _handle_getUserInfoComplete);
		}
		
		private function _handle_getUserInfoComplete(event:FacebookEvent):void
		{
			var getInfoData:GetInfoData = GetInfoData(event.data);
			var facebookUser:FacebookUser = FacebookUser(getInfoData.userCollection.getItemAt(0));
			
			var uvo:UserVO = new UserVO();
			
			uvo.uid = facebookUser.uid;
			uvo.firstName = facebookUser.first_name ? facebookUser.first_name : "";
			uvo.nickname = "";
			uvo.lastName = facebookUser.last_name ? facebookUser.last_name : "";
			uvo.photoBig = facebookUser.pic_big ? facebookUser.pic_big : "";
			
			if(facebookUser.sex == "male" || facebookUser.sex == "female") uvo.gender = facebookUser.sex == "male" ? "male" : "female" ;
			else uvo.gender = facebookUser.sex == "мужской" ? "male" : "female";
			
			uvo.city = facebookUser.current_location ? facebookUser.current_location.city : "";
			uvo.age = facebookUser.birthdayDate ? String(new Date().fullYear - facebookUser.birthdayDate.fullYear) : "";
			
			callback.onResult(uvo);
		}
		
		//
		
		public function getURL(url:String):void
		{
			navigateToURL(new URLRequest(url));
		}
		
		//
		
		public function getViewer():void
		{
			var call:FacebookCall = _facebookSession.facebook.post(new GetInfo([_facebookSession.facebook.uid], GetInfoFieldValues.ALL_VALUES));
			call.addEventListener(FacebookEvent.COMPLETE, _handle_getViewerComplete);
		}
		
		private function _handle_getViewerComplete(event:FacebookEvent):void
		{
			var getInfoData:GetInfoData = GetInfoData(event.data);
			var facebookUser:FacebookUser = FacebookUser(getInfoData.userCollection.getItemAt(0));
			
			var uvo:UserVO = new UserVO();
			
			uvo.uid = facebookUser.uid;
			uvo.firstName = facebookUser.first_name ? facebookUser.first_name : "";
			uvo.nickname = "";
			uvo.lastName = facebookUser.last_name ? facebookUser.last_name : "";
			uvo.photoBig = facebookUser.pic_big ? facebookUser.pic_big : "";
			
			callback.onResult(uvo);
		}
		
		//
	}
}