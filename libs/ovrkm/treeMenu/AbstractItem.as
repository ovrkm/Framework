package ovrkm.treeMenu
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import ovrkm.treeMenu.events.MenuEvent;

	public class AbstractItem extends MovieClip
	{
		public var id:String;
		
		public var added:Boolean;
		public var removing:Boolean;
		
		public var block:Boolean;
		
		public function AbstractItem()
		{
			super();
			
			mouseChildren = true;
			buttonMode = true;
			
			addEventListener(MouseEvent.CLICK, click);
			addEventListener(MouseEvent.MOUSE_OVER, over);
			addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		protected function click(event:MouseEvent):void
		{
			if(block) return;
			
			dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK));
		}
		
		protected function over(event:MouseEvent):void
		{
			if(block) return;
			
			dispatchEvent(new MenuEvent(MenuEvent.ITEM_OVER));
		}
		
		protected function out(event:MouseEvent):void
		{
			if(block) return;
			
			dispatchEvent(new MenuEvent(MenuEvent.ITEM_OUT));
		}
	}
}