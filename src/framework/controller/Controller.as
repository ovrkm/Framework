/**
 * Created by IntelliJ IDEA.
 * User: Krasnov
 * Date: 19.07.11
 * Time: 17:53
 * To change this template use File | Settings | File Templates.
 */
package framework.controller
{

	import flash.events.Event;

	import framework.model.Model;

	public class Controller
	{
		public var transitionController:TransitionController;

		public function Controller(model:Model)
		{
			transitionController = new TransitionController(model);
		}

		public function launch():void
		{
			transitionController.playLaunch();
		}

		public function playOut():void
		{
			transitionController.playOut();
		}

		public function menuButtonClicked(event:Event):void
		{

		}
	}
}