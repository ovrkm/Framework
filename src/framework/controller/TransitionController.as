/**
 * Created by IntelliJ IDEA.
 * User: Krasnov
 * Date: 19.07.11
 * Time: 19:03
 * To change this template use File | Settings | File Templates.
 */
package framework.controller
{

	import com.greensock.TimelineMax;
	import com.greensock.events.TweenEvent;

	import framework.model.Model;
	import framework.view.Comp;
	import framework.view.Comp1;

	public class TransitionController
	{
		private var model:Model;

		public var comp:Comp;
		public var comp1:Comp1;

		public function TransitionController(model:Model)
		{
			this.model = model;
		}

		public var currentTransition:TimelineMax;

		public function playLaunch():void
		{
			stopCurrentTransition();

			currentTransition = new TimelineMax({useFrames:true});
			currentTransition.addEventListener(TweenEvent.COMPLETE, currentTransition_completeHandler);
			currentTransition.append(comp.getInTimeline());
			currentTransition.append(comp1.getInTimeline());
		}

		private function currentTransition_completeHandler(event:TweenEvent):void
		{
			model.launched = true;
		}

		//

		public function playOut():void
		{
			stopCurrentTransition();

			currentTransition = new TimelineMax({useFrames:true});
			currentTransition.append(comp.getOutTimeline());
			currentTransition.append(comp1.getOutTimeline());
		}

		//

		public function stopCurrentTransition():void
		{
			if (currentTransition) currentTransition.complete();
		}
	}
}
