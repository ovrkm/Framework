package ovrkm.components
{
	public class BaseInOutPage extends BaseComponent
	{
		public static const OUT:String = "out";

		public function BaseInOutPage()
		{
			stop();

			addScript(1, stop);
			addScript(totalFrames, showHandler);

			var showedFrame:int = getFrameByLabel(OUT)-1;
			gotoAndStop(showedFrame);

			addScript(showedFrame, hiddenHandler);
		}

		override public function show(duration:Number = NaN, delay:Number = 0):void
		{
			gotoAndPlay(OUT);
		}

		override protected function showHandler():void
		{
			super.showHandler();
		}

		override public function hide(duration:Number = NaN, delay:Number = 0):void
		{
			gotoAndPlay(2);
		}

		override protected function hiddenHandler():void
		{
			stop();
			super.hiddenHandler();
		}
	}
}
