package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;
	
	public class HLeft extends Sprite
	{
		public function HLeft()
		{
			super();
			
			graphics.beginFill(0xFF0000, 1);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}
	}
}