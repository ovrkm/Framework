package ovrkm.components.events
{
	import flash.events.Event;

	public class BaseComponentEvent extends Event
	{
		public static const SHOW:String = "BaseComponentEvent.Show";
		public static const HIDE:String = "BaseComponentEvent.Hide";
		public static const SHOWED:String = "BaseComponentEvent.Showed";
		public static const HIDDEN:String = "BaseComponentEvent.Hidden";
		
		public function BaseComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}