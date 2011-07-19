package ovrkm.scroll.events
{
	import flash.events.Event;

	public class ScrollEngineEvent extends Event
	{
		public static const SCROLL:String = "ScrollEngineEvent.scroll";
		
		public function ScrollEngineEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:ScrollEngineEvent = new ScrollEngineEvent(type, bubbles, cancelable);
			return event;
		}
	}
}