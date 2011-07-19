package ovrkm.scroll.engines
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class HorizontalScroll extends EventDispatcher implements IScrollEngine
	{
		private var _track:DisplayObject;
		private var _drag:DisplayObject;
		private var _content:DisplayObject;
		private var _contentMask:DisplayObject;
		
		public function HorizontalScroll(track:DisplayObject, drag:DisplayObject, content:DisplayObject, contentMask:DisplayObject)
		{
			this._track = track;
			this._drag = drag;
			this._content = content;
			this._contentMask = contentMask;
			
			initDrag();
		}
		
		//////////////////////////////////
		// DRAG //////////////////////////
		
		private function initDrag():void
		{
			_drag.addEventListener(MouseEvent.MOUSE_DOWN, dragMouseDownHandler);
		}
		
		private var dragOffset:Number;
		
		private function dragMouseDownHandler(event:MouseEvent):void
		{
			dragOffset = event.localX;
			
			_drag.root.addEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);
			_drag.stage.addEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);
			_drag.addEventListener(Event.ENTER_FRAME, dragEnterFrameHandler);
		}
		
		private function dragMouseUpHandler(event:MouseEvent):void
		{
			_drag.root.removeEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);
			_drag.stage.removeEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);
			_drag.removeEventListener(Event.ENTER_FRAME, dragEnterFrameHandler);
		}
		
		private function dragEnterFrameHandler(event:Event):void
		{			
			var dragXY:Number = _drag.parent.mouseX-dragOffset;
			
			if(dragXY <= _track.x) dragXY = _track.x;
			if(dragXY+_drag.width >= _track.x+_track.width) dragXY = _track.x+_track.width-_drag.width;
			
			_drag.x = dragXY;
			
			position = (_drag.x-_track.x)/(_track.width-_drag.width);
		}
		
		//////////////////////////////////
		//////////////////////////////////
		
		public function set position(val:Number):void
		{
			scroll(val*(_track.width-_drag.width), -val*(_content.width-_contentMask.width));
		}
		
		public function get position():Number
		{
			return (_drag.x-_track.x)/(_track.width-_drag.width);
		}
		
		//////////////////////////////////
		// BAR ///////////////////////////
		
		private function _initBar():void
		{
			
		}
		
		//////////////////////////////////
		//////////////////////////////////
		
		private function scroll(dragPosition:Number, contentPosition:Number):void
		{
			_drag.x = _track.x + dragPosition;
			_content.x = _contentMask.x + contentPosition;
		}
		
		//
		
		private var _controlsVisible:Boolean;
		
		public function set controlsVisible(val:Boolean):void
		{
			_controlsVisible = val;
			
			_drag.visible = _track.visible = val;
		}
		
		public function get controlsVisible():Boolean
		{
			return _controlsVisible;
		}

		public function get track():DisplayObject
		{
			return _track;
		}

		public function get drag():DisplayObject
		{
			return _drag;
		}

		public function get content():DisplayObject
		{
			return _content;
		}

		public function get contentMask():DisplayObject
		{
			return _contentMask;
		}
	}
}