package ovrkm.scroll.pane.elements
{
	import flash.display.Sprite;
	
	public class VTrack extends Sprite
	{
		public function VTrack()
		{
			super();
			
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawRect(0,0,10,10);
			graphics.endFill();
		}
	}
}