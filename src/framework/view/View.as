package
framework.view{
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import framework.controller.Controller;
	import framework.controller.TransitionController;

	import framework.model.Model;

	import ovrkm.BaseComponent;

	public class View extends MovieClip
	{
		public var model:Model;
		public var controller:Controller;

		private var components:Array;
		private var componentsAdded:int;

		public function View()
		{
			model = new Model();
			controller = new Controller(model);

			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, true);

			components =
			[
				Comp,
				Comp1,
				Main,
				Menu
			];

			addChild(new Main());
		}

		private function addedToStageHandler(event:Event):void
		{
			var transitionController:TransitionController = controller.transitionController;

			var target:Object = event.target;
			if(target is IViewComponent)
			{

				if(target is Comp) transitionController.comp = Comp(target);
				if(target is Comp1) transitionController.comp1 = Comp1(target);

				IViewComponent(target).inject(model, controller);
				componentsAdded++;

				if(componentsAdded == components.length) controller.launch();
			}
		}
	}
}