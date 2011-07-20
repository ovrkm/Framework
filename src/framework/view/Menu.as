package framework.view
{

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import framework.controller.Controller;

	import framework.model.Model;

	import mx.effects.Tween;

	public class Menu extends MovieClip implements IViewComponent
	{
		public var b1:MovieClip;
		public var b2:MovieClip;
		public var b3:MovieClip;
		public var b4:MovieClip;

		private var buttons:Array;
		private var c:Controller;

		public function Menu()
		{
			buttons = [b1,b2,b3,b4];

			for (var i:int = 0; i < buttons.length; i++)
			{
				var button:MovieClip = buttons[i];
				button.buttonMode = true;
			}

			alpha = 0;
		}

		public function inject(m:Model, c:Controller):void
		{
			this.c = c;

			m.addEventListener(Model.LAUNCHED, launchedHandler);

		}

		private function launchedHandler(event:Event):void
		{
			TweenMax.to(this, .3, {alpha:1});

			addEventListener(MouseEvent.CLICK, clickHandler, true);
		}

		private function clickHandler(event:MouseEvent):void
		{
			if(buttons.indexOf(event.target) != -1) c.menuButtonClicked(event);

		}
	}
}