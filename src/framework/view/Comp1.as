package framework.view{

	import flash.display.MovieClip;

	import framework.controller.Controller;

	import framework.model.Model;

	import ovrkm.BaseComponent;

	public class Comp1 extends BaseComponent implements IViewComponent
	{
		public function Comp1()
		{
			super();
		}

		public function inject(m:Model, c:Controller):void
		{

		}
	}
}