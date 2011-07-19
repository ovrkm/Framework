package ovrkm.components
{
	import com.greensock.TweenMax;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	import ovrkm.components.events.BaseComponentEvent;
	
	[Event(name="show", type="ovrkm.components.events.BaseComponentEvent")]
	[Event(name="hide", type="ovrkm.components.events.BaseComponentEvent")]
	[Event(name="showed", type="ovrkm.components.events.BaseComponentEvent")]
	[Event(name="hidden", type="ovrkm.components.events.BaseComponentEvent")]
	public class BaseComponent extends MovieClip
	{
		public function show(duration:Number=NaN, delay:Number=0):void
		{
			duration = duration || .3;
			
			TweenMax.killTweensOf(this);
			TweenMax.to(this, duration, {delay:delay, alpha:1, onComplete:showHandler});
			
			dispatchEvent(new BaseComponentEvent(BaseComponentEvent.SHOW));
		}
		
		protected function showHandler():void
		{
			dispatchEvent(new BaseComponentEvent(BaseComponentEvent.SHOWED));
		}
		
		public function hide(duration:Number=NaN, delay:Number=0):void
		{
			duration = duration || .3;
			
			TweenMax.killTweensOf(this);
			TweenMax.to(this, duration, {delay:delay, alpha:0, onComplete:hiddenHandler});
			
			dispatchEvent(new BaseComponentEvent(BaseComponentEvent.HIDE));
		}
		
		protected function hiddenHandler():void
		{
			dispatchEvent(new BaseComponentEvent(BaseComponentEvent.HIDDEN));
		}
		
		public function remove():void
		{
			parent.removeChild(this);
		}
		
		public function set blockEnabled(val:Boolean):void
		{
			mouseEnabled = mouseChildren = !val;
		}
		
		public function get blockEnabled():Boolean
		{
			return !mouseEnabled;
		}

		public function getFrameByLabel(name:String):uint
		{
			for (var i:int = 0; i < currentLabels.length; i++)
			{
				var frameLabel:FrameLabel = currentLabels[i];
				if(frameLabel.name == name) return frameLabel.frame;
			}
			
			return null;
		}

		public function addScript(frame:Object, handler:Function):Boolean
		{
			if(frame is uint)
			{
				addFrameScript(uint(frame)-1, handler);
				return true;
			}

			if(frame is String)
			{
				addFrameScript(getFrameByLabel(String(frame))-1, handler);
				return true;
			}

			return false;
		}
	}
}