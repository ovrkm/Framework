package framework.view{

	import flash.display.MovieClip;

	import framework.controller.Controller;

	import framework.model.Model;

	import ovrkm.BaseComponent;

	public class Comp extends BaseComponent implements IViewComponent
	{
		public function Comp()
		{
			super();
		}
		
		public function inject(m:Model, c:Controller):void
		{

		}
	}
}