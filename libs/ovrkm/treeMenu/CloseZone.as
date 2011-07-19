package ovrkm.treeMenu
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class CloseZone extends Sprite
	{
		public static const MOUSE_OUT:String = "CloseZone.mouseOut";
		
		private var _g:Graphics;
		
		private var _mouseIsOut:Boolean = true;
		
		public function CloseZone()
		{
			super();
			
			_g = graphics;
			
			addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
		}
		
		public function _enterFrameHandler(event:Event):void
		{
			var hit:Boolean = hitTestPoint(mouseX, mouseY, true);
			
			if(!hit && !_mouseIsOut)
			{
				_mouseIsOut = true;
				dispatchEvent(new Event(MOUSE_OUT));
			}
			else if(hit) _mouseIsOut = false;
		}
		
		public function draw(b:Rectangle):void
		{
			_g.beginFill(0xFF0000, 0);
			_g.drawRect(b.x, b.y, b.width, b.height);
			_g.endFill();
		}
		
		public function clear():void
		{
			_g.clear();
		}
	}
}