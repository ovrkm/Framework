package ovrkm.socialNetwork
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.xml.XMLNode;

	import ovrkm.utils.Callback;

	import ru.vkontakte.VKApp;
	
	import ovrkm.socialNetwork.vo.UserVO;

	public class VkontakteDelegate implements ISocialNetworkDelegate
	{
		private var callback:Callback;
		private var wrapper:Object;
		private var parameters:Object;
		
		private var _vk:VKApp;
		
		public function VkontakteDelegate(client:Object, app_params:Object, wrapper:Object, callback:Callback)
		{
			this.callback = callback;
			this.wrapper = wrapper;
			this.parameters = app_params;
			
			_vk = client as VKApp;
		}
		
		/////////////////////////
		/////////////////////////
		
		public function postResult(id:String, message:String):void
		{
			_vk.wall_savePost1("62551_180935072", id, message, _wall_saveMessageResponse);
		}
		
		public function _wall_saveMessageResponse(result:XML):void
		{
			wrapper.external.saveWallPost(result.post_hash);
		}

		///!!!!!!!!!!!!!!!
		
		//_vk.getUserSettings(_responseGetUserSettings);
		private var _settingsFlag:uint = 512+4;
		private function _responseGetUserSettings(result:XML):void 
		{
			if(result.settings < _settingsFlag) 
			{
				wrapper.addEventListener("onSettingsChanged", _onSettingsChanged); 
				wrapper.external.showSettingsBox(_settingsFlag);
				
			}
			else _savePost();
		}
		
		private function _onSettingsChanged(event:Event):void
		{
			if(event["settings"] < _settingsFlag) 
			{
				wrapper.addEventListener("onSettingsChanged", _onSettingsChanged);
				wrapper.external.showSettingsBox(_settingsFlag);
				
			}
			else _savePost();
		}
		
		private function _savePost():void
		{
			var mess:String = "666";
			
			_vk.wall_savePost1("62551_157169653", parameters.viewer_id, mess, _responseWall_savePost1);
			
			// img2
			//_vk.wall_savePost1("62551_155517526", data.viewer_id, mess, _responseWall_savePost1);
		}
		
		private function _responseWall_savePost1(result:XML):void
		{
			//_httpProxy.sendDataToScript(getUser().name, getUser().id, "v_", String(_statProxy.getResultGameTime()));
			wrapper.external.saveWallPost(result.post_hash);
		}
		
		/*
		public function checkIfInstaled():void
		{
			_vk.isAppUser(getUser().id, _isAppUserResponse);
		}
		
		private function _isAppUserResponse(result:XML):void
		{
			if(result == "1") sendNotification(IS_INSTALLED);
			else sendNotification(IS_NOT_INSTALLED);
		}
		
		public function installApp():void
		{
			wrapper.addEventListener("onApplicationAdded", _onApplicationAdded);
			wrapper.external.showInstallBox();
		}
		
		private function _onApplicationAdded(event:Event):void
		{
			//sendNotification(IS_INSTALLED);
		}
		*/
		////////////////////////////////////////////////
		
		/*
		public function getUser():UserVO
		{
			return new UserVO(parameters.viewer_id, _userName);
		}*/
		
		//!!!!!!!!!!!
		
		public function navigateToUser(id:String):void
		{
			navigateToURL(new URLRequest("/id"+ id), "_blank");
		}
		
		public function showInviteBox():void
		{
			wrapper.external.showInviteBox();
		}
		
		/////////////////////////
		
		public function getFriends():void
		{
			_vk.getFriendsIDs(_getFriendsResponse);
		}
		
		private function _getFriendsResponse(result:XML):void
		{
			var uids:String = "";
			
			for each(var node:XML in result.uid)
			{
				if(uids == "")
				{
					uids += node.valueOf();
					continue;
				}
				
				uids +=  ", " + node.valueOf();
			}
			
			// uid, first_name, last_name, nickname, domain, sex, bdate (birthdate), city, country, timezone, photo, photo_medium, photo_big, has_mobile, rate, contacts, education
			var fields:String = "uid, first_name, nickname, last_name, photo";
			
			_vk.getProfiles(_getProfilesResponse, uids, fields);
		}
		
		public function _getProfilesResponse(result:XML):void
		{
			var uvo:UserVO;
			var uvos:Array = []
			
			for each(var node:XML in result.user)
			{
				uvo = new UserVO();
				
				uvo.uid = node.uid;
				uvo.firstName = node.first_name;
				uvo.lastName = node.last_name;
				uvo.photoSmall = node.photo;
				
				uvos.push(uvo);
			}
			
			callback.onResult(uvos);
		}
		
		/////////////////////////
		
		private var _uvo:UserVO 
		
		public function getUserInfo(id:String):void
		{
			var fields:String = "uid, first_name, nickname, last_name, photo, photo_big, sex, birthdate, city";
			_vk.getProfiles(_getUserInfoResponse, id, fields);
		}
		
		private function _getUserInfoResponse(result:XML):void 
		{
			_uvo = new UserVO();
			var node:XML = result.user[0];
			
			_uvo.uid = node.uid;
			_uvo.firstName = node.first_name;
			_uvo.nickname = node.nickname;
			_uvo.lastName = node.last_name;
			_uvo.photoBig = node.photo_big;
			_uvo.gender = node.sex == 1 ? "female" : "male" ;
			_uvo.city = node.city;
			
			var age:uint;
			var birthArr:Array = String(node.bdate).split(".");
			var curDate:Date = new Date();
			
			if(birthArr.length == 3)
			{
				age = curDate.getFullYear() - Number(birthArr[2]) - 1;
				
				if(curDate.getMonth()+1 > Number(birthArr[1])) age++;
				else if(curDate.getMonth()+1 == Number(birthArr[1]))
					if(curDate.getDate() >= Number(birthArr[0])) age++;
			}
			
			_uvo.age = age > 0 ? String(age) : "" ;
			
			_vk.places_getCityById(_places_getCityByIdResponse, node.city);
		}
		
		private function _places_getCityByIdResponse(result:XML):void
		{
			_uvo.city = result.city.name;
			
			callback.onResult(_uvo);
		}
		
		/////////////////////////
		
		public function getURL(url:String):void
		{
			navigateToURL(new URLRequest(url), "_blank");
			
			//wrapper.external.navigateToURL(new URLRequest(url));
		}
		
		/////////////////////////
		
		public function getViewer():void
		{
			var fields:String = "uid, first_name, nickname, last_name, photo, photo_big, sex, birthdate, city";
			_vk.getProfiles(_getViewerResponse, parameters.viewer_id, fields);
		}
		
		private function _getViewerResponse(result:XML):void 
		{
			_uvo = new UserVO();
			var node:XML = result.user[0];
			
			_uvo.uid = node.uid;
			_uvo.firstName = node.first_name;
			_uvo.nickname = node.nickname;
			_uvo.lastName = node.last_name;
			_uvo.photoBig = node.photo_big;
			
			callback.onResult(_uvo);
		}
	}
}


class DateMath {
	public static function addWeeks(date:Date, weeks:Number):Date {
		return addDays(date, weeks*7);
	}
	
	public static function addDays(date:Date, days:Number):Date {
		return addHours(date, days*24);
	}
	
	public static function addHours(date:Date, hrs:Number):Date {
		return addMinutes(date, hrs*60);
	}
	
	public static function addMinutes(date:Date, mins:Number):Date {
		return addSeconds(date, mins*60);
	}
	
	public static function addSeconds(date:Date, secs:Number):Date {
		var mSecs:Number = secs * 1000;
		var sum:Number = mSecs + date.getTime();
		return new Date(sum);
	}
}