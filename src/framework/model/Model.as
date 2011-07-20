/**
 * Created by IntelliJ IDEA.
 * User: Krasnov
 * Date: 19.07.11
 * Time: 17:53
 * To change this template use File | Settings | File Templates.
 */
package framework.model
{

	import flash.display.Sprite;
	import flash.events.Event;

	public class Model extends Sprite
	{
		public static const LAUNCHED:String = "launched";

		private var _launched:Boolean;

		public function Model()
		{

		}

		public function get launched():Boolean
		{
			return _launched;
		}

		public function set launched(value:Boolean):void
		{
			if(!value) return;

			_launched = value;

			dispatchEvent(new Event(LAUNCHED));
		}
	}
}
