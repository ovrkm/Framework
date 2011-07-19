package framework.view
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import framework.controller.Controller;

	import framework.model.Model;

	import ovrkm.BaseComponent;

	public class Main extends BaseComponent implements IViewComponent
	{
		private var c:Controller;

		public function Main()
		{

		}

		public function inject(m:Model, c:Controller):void
		{
			this.c = c;
		}
	}
}