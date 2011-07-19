package
{
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	import ovrkm.BaseComponent;

	public class View extends MovieClip
	{
		private var comp:BaseComponent;

		public function View()
		{
			comp = new Comp();
			addChild(comp);

			comp.show();
			
			addEventListener(MouseEvent.CLICK, clickHandler);
		}

		private function clickHandler(event:MouseEvent):void
		{
			comp.hide();
		}
	}
}