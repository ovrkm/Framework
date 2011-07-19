package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;

	public class VDrag extends Sprite
	{
		public function VDrag()
		{
			super();
			
			graphics.beginFill(0xFFFF00, 1);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}
	}
}