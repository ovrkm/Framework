package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;
	
	public class HTrack extends Sprite
	{
		public function HTrack()
		{
			super();
			
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}
	}
}