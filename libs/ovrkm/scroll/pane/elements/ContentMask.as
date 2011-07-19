package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;

	public class ContentMask extends Sprite
	{
		public function ContentMask()
		{
			super();
			
			graphics.beginFill(0x00FF00, 1);
			graphics.drawRect(0,0,100,100);
			graphics.endFill();
		}
	}
}