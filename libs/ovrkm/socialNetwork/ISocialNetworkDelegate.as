package ovrkm.socialNetwork
{
	import ovrkm.socialNetwork.vo.UserVO;

	public interface ISocialNetworkDelegate
	{
		function postResult(id:String, message:String):void
		function getFriends():void
		function navigateToUser(id:String):void
		function showInviteBox():void
		function getUserInfo(id:String):void
		function getURL(url:String):void
		function getViewer():void
	}
}