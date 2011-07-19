package ovrkm.scroll.pane
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import flash.ui.Keyboard;

	import ovrkm.scroll.engines.HorizontalScroll;
	import ovrkm.scroll.engines.VerticalScroll;
	import ovrkm.scroll.modes.MouseWheelScrollMode;
	import ovrkm.scroll.pane.elements.Content;
	import ovrkm.scroll.pane.elements.ContentMask;
	import ovrkm.scroll.pane.elements.HDrag;
	import ovrkm.scroll.pane.elements.HLeft;
	import ovrkm.scroll.pane.elements.HRight;
	import ovrkm.scroll.pane.elements.HTrack;
	import ovrkm.scroll.pane.elements.VDown;
	import ovrkm.scroll.pane.elements.VDrag;
	import ovrkm.scroll.pane.elements.VTrack;
	import ovrkm.scroll.pane.elements.VUp;

	public class Pane extends Sprite
	{
		//
		
		private var htrack:DisplayObject;
		protected function getHTrackClass():Class { return HTrack; }
		
		private var hdrag:DisplayObject;
		protected function getHDragClass():Class { return HDrag; }
		
		
		private var hleft:DisplayObject;
		protected function getHLeftClass():Class { return HLeft; }
		
		private var hright:DisplayObject;
		protected function getHRightClass():Class { return HRight; }
		
		//
		
		private var vtrack:DisplayObject;
		protected function getVTrackClass():Class { return VTrack; }
		
		private var vdrag:DisplayObject;
		protected function getVDragClass():Class { return VDrag; }
		
		private var vup:DisplayObject;
		protected function getVUpClass():Class { return VUp; }
		
		private var vdown:DisplayObject;
		protected function getVDownClass():Class { return VDown; }
		
		//
		
		private var content:DisplayObject;
		protected function getContentClass():Class { return Content; }
		
		private var contentMask:DisplayObject;
		protected function getContentMaskClass():Class { return ContentMask; }
		
		//
		
		private var verticalScroll:VerticalScroll;
		private var horizontalScroll:HorizontalScroll;
		
		//
		
		public function Pane()
		{
			super();
			
			//
			var elementClass:Class = getHTrackClass();
			
			elementClass = getHTrackClass();
			htrack = new elementClass() as DisplayObject;
			addChild(htrack);
			
			elementClass = getHDragClass();
			hdrag = new elementClass() as DisplayObject;
			addChild(hdrag);
			
			elementClass = getHLeftClass();
			hleft = new elementClass() as DisplayObject;
			addChild(hleft);
			
			elementClass = getHRightClass();
			hright = new elementClass() as DisplayObject;
			addChild(hright);
			
			//
			
			elementClass = getVTrackClass();
			vtrack = new elementClass() as DisplayObject;
			addChild(vtrack);
			
			elementClass = getVDragClass();
			vdrag = new elementClass() as DisplayObject;
			addChild(vdrag);
			
			elementClass = getVUpClass();
			vup = new elementClass() as DisplayObject;
			addChild(vup);
			
			elementClass = getVDownClass();
			vdown = new elementClass() as DisplayObject;
			addChild(vdown);
			
			//
			
			elementClass = getContentClass();
			content = new elementClass() as DisplayObject;
			addChild(content);
			
			elementClass = getContentMaskClass();
			contentMask = new elementClass() as DisplayObject;
			addChild(contentMask);
			
			content.mask = contentMask;
			
			_updatePosition();
			
			_initScroll();
		}
		
		override public function set width(value:Number):void
		{
			contentMask.width = value - Math.max(vup.width, vdown.width);
			_updatePosition();
		}

		override public function get width():Number
		{
			return contentMask.width;
		}

		override public function set height(value:Number):void
		{
			contentMask.height = value - Math.max(hleft.width, hleft.width);
			_updatePosition();
		}

		override public function get height():Number
		{
			return contentMask.height;
		}

		private function _updatePosition():void
		{
			contentMask.x = content.x;
			contentMask.y = content.y;
			
			//
			
			hleft.y = contentMask.y + contentMask.height;
			
			hright.x = contentMask.x + contentMask.height - hright.width;
			hright.y = contentMask.y + contentMask.height;
			
			htrack.x = hleft.x + hleft.width;
			htrack.y = contentMask.y + contentMask.height;
			htrack.width = contentMask.width - hleft.width - hright.width;
			
			hdrag.x = htrack.x;
			hdrag.y = htrack.y;
			
			//
			
			vup.x = contentMask.x + contentMask.width;
			
			vdown.x = contentMask.x + contentMask.width;
			vdown.y = contentMask.y + contentMask.height - vdown.height;
			
			vtrack.x = contentMask.x + contentMask.width;
			vtrack.y = vup.y + vup.height;
			vtrack.height = contentMask.height - vup.height - vdown.height;
			
			vdrag.x = vtrack.x;
			vdrag.y = vtrack.y;
		}
		
		private function _initScroll():void
		{
			verticalScroll = new VerticalScroll(vtrack, vdrag, content, contentMask);
			horizontalScroll = new HorizontalScroll(htrack, hdrag, content, contentMask);

			new MouseWheelScrollMode(horizontalScroll, contentMask.width, content.width, Keyboard.SHIFT);
			new MouseWheelScrollMode(verticalScroll, contentMask.height, content.height);
		}
	}
}