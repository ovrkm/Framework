package ovrkm.components
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	import ovrkm.components.BaseComponent;

	public class BaseAnimatedButton extends BaseComponent
	{
		public var but:SimpleButton;

		public function BaseAnimatedButton()
		{
			super();

			stop();

			addScript(getFrameByLabel("out")-1, stop);
			addScript(1, stop);

			but.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			but.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}

		private function mouseOverHandler(event:MouseEvent):void
		{
			gotoAndPlay("in");
		}

		private function mouseOutHandler(event:MouseEvent):void
		{
			gotoAndPlay("out");
		}
	}
}