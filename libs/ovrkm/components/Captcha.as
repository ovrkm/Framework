package ovrkm.components
{
	import com.greensock.TweenMax;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class Captcha extends MovieClip
	{
		private var _url:String;
		private var _loader:Loader;
		
		public function Captcha()
		{
			super();
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _loaderComplete);
			addChild(_loader);
			
			buttonMode = true;
			mouseChildren = true;
			
			addEventListener(MouseEvent.CLICK, _click);
		}
		
		public function setImageURL(url:String):void
		{
			_url = url;
		}
		
		public function refresh():void
		{
			var reload:String = "";
			if (_loader.content) reload = "?reload&ac="+Math.random()
			else reload = "?" + Math.random();
				
			var tween:TweenMax = TweenMax.to(this, .3, {alpha:0, 
				onComplete:_loader.load, 
				onCompleteParams:[new URLRequest(_url + reload)]});
			
			if(alpha == 0) tween.totalProgress = 1;
		}
		
		private function _loaderComplete(event:Event):void
		{
			TweenMax.to(this, .3, {alpha:1});
		}
		
		private function _click(event:MouseEvent):void
		{
			refresh();
		}
	}
}