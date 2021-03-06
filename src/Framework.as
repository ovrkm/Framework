package
{

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	import framework.view.View;

	public class Framework extends MovieClip
	{

		[Embed(source="assets/assets.swf", mimeType="application/octet-stream")]
		private var AssetsClass:Class;

		public function Framework()
		{
			"sdsdsd"

			1111

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			var assetsBytes:ByteArray = new AssetsClass();

			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(assetsBytes, new LoaderContext(false, ApplicationDomain.currentDomain));
		}

		private function completeHandler(event:Event):void
		{
			addChild(new View());
		}
	}
}