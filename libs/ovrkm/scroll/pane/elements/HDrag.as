package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;

	public class HDrag extends Sprite
	{
		public function HDrag()
		{
			super();
			
			graphics.beginFill(0xFFFF00, 1);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}
	}
}