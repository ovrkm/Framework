package
{
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	public class View extends MovieClip
	{
		private var comp:BaseComponent;

		public function View()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;

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