package ovrkm.treeMenu.events
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const ITEM_CLICK:String = "MenuEvent.itemClick";
		public static const ITEM_OVER:String = "MenuEvent.itemOver";
		public static const ITEM_OUT:String = "MenuEvent.itemOut";
		
		public function MenuEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}