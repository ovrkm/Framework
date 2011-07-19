package ovrkm.net.amfphp
{
	import flash.events.Event;

	public class ConnectionEvent extends Event
	{
		public static const SUCCESS:String = "success";
		public static const FAULT:String = "fault";

		public var result:Object;

		public function ConnectionEvent(type:String)
		{
			super(type, bubbles, cancelable)
		}

		override public function clone():Event
		{
			var connectionEvent:ConnectionEvent = new ConnectionEvent(type);
			connectionEvent.result = result;
			return connectionEvent;
		}
	}
}