package ovrkm.scroll.modes
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import ovrkm.scroll.engines.IScrollEngine;

	public class MouseWheelScrollMode
	{
		private var contentMask:Sprite;

		private var scrollEngine:IScrollEngine;

		private var content:Sprite;

		public var maskSize:Number;

		public var contentSize:Number;

		private var keysPressed:Array = [];
		private var modificatorKeyCode:Number;

		public function MouseWheelScrollMode(scrollEngine:IScrollEngine, maskSize:Number, contentSize:Number, modificatorKeyCode:Number=NaN)
		{
			this.modificatorKeyCode = modificatorKeyCode;
			this.scrollEngine = scrollEngine;
			this.contentMask = scrollEngine.contentMask as Sprite;
			this.maskSize = maskSize;
			this.contentSize = contentSize;

			contentMask.buttonMode = true;
			contentMask.useHandCursor = false;

			addListeners();
		}

		private function addListeners():void
		{
			contentMask.addEventListener(MouseEvent.MOUSE_WHEEL, contentMask_mouseWheelHandler);

			contentMask.addEventListener(Event.ADDED_TO_STAGE, contentMask_addedToStageHandler);
		}

		private function contentMask_addedToStageHandler(event:Event):void
		{
			contentMask.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			contentMask.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}

		private function contentMask_mouseWheelHandler(event:MouseEvent):void
		{
			var sizeFactor:Number = contentSize/maskSize;

			if(!isNaN(modificatorKeyCode))
			{
				if(!keysPressed[modificatorKeyCode]) return;
			}
			else
			{
				for each (var pressed:Boolean in keysPressed)
					if(pressed) return;
			}

			if(sizeFactor <= 1) return;

			var newPosition:Number = scrollEngine.position - ((.1 * event.delta) / sizeFactor);

			trace(((.1 * event.delta) / sizeFactor));

			if(newPosition < 0) newPosition = 0;
			else if(newPosition > 1) newPosition = 1;

			scrollEngine.position = newPosition;
		}

		private function keyDownHandler(event:KeyboardEvent):void
		{
			keysPressed[event.keyCode] = true;
		}

		private function keyUpHandler(event:KeyboardEvent):void
		{
			keysPressed[event.keyCode] = false;
		}
	}
}