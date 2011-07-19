package ovrkm.treeMenu.events
{
	import flash.events.Event;
	import ovrkm.data.Collection;
	
	public class RenderEvent extends Event
	{
		public static const REMOVE_ITEMS:String = "RenderEvent.removeItems";
		public static const ADD_ITEMS:String = "RenderEvent.addItems";
		
		public var items:Collection;
		
		public function RenderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}