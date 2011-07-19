package ovrkm.treeMenu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ovrkm.data.Collection;
	import ovrkm.treeMenu.collections.ItemsCollection;
	import ovrkm.treeMenu.events.MenuEvent;
	import ovrkm.treeMenu.renders.Render;
	import ovrkm.treeMenu.renders.VerticalRender;

	public class TreeMenu extends MovieClip
	{
		private var ITEM_GAP:Number = 0;
		
		public var closeZone:CloseZone;
		
		public var items:ItemsCollection;
		
		public var renderClass:Class = VerticalRender;
		//public var renderClass:Class = HorizontalRender;
		
		public var itemsContainer:Sprite;
		
		public function TreeMenu()
		{
			super();
			
			closeZone = new CloseZone();
			closeZone.addEventListener(CloseZone.MOUSE_OUT, _closeZoneMouseOut)
			
			addChild(closeZone);
			
			itemsContainer = new Sprite();
			addChild(itemsContainer);
			
			addEventListener(MenuEvent.ITEM_CLICK, _itemClick);
			addEventListener(MenuEvent.ITEM_OVER, _itemOver);
			addEventListener(MenuEvent.ITEM_OUT, _itemOut);
		}
		
		public function buildMenu(items:ItemsCollection):void
		{
			this.items = items;
			
			_buildItemTree("", false);
		}
		
		private function _itemClick(event:MenuEvent):void
		{
			var item:AbstractItem = event.target as AbstractItem;
			
			_buildItemTree();
		}
		
		private function _itemOver(event:MenuEvent):void
		{
			var item:AbstractItem = event.target as AbstractItem;
			
			_buildItemTree(item.id);
		}
		
		private function _itemOut(event:MenuEvent):void
		{
			var item:AbstractItem = event.target as AbstractItem;
		}
		
		private function _closeZoneMouseOut(event:Event):void
		{
			_buildItemTree();
		}
		
		///////////////////////////////////////////////////////////////////////
		
		private function _buildItemTree(id:String="", anim:Boolean = true):void
		{
			var render:Render = new renderClass(items.getLevels(id), this) as Render;
			
			render.change(anim);
		}
		
		public function removeItems(items:Collection):void
		{
			var item:AbstractItem;
			
			for(var i:uint = 0; item = items.getItemAt(i) as AbstractItem; i++)
				_removeItem(item);
		}
		
		public function addItems(items:Collection):void
		{
			var item:AbstractItem;
			
			for(var i:uint = 0; item = items.getItemAt(i) as AbstractItem; i++)
				_addItem(item);
		}
		
		private function _addItem(item:AbstractItem):void
		{
			item.added = true;
			itemsContainer.addChild(item);
		}
		
		private function _removeItem(item:AbstractItem):void
		{
			item.added = false;
			item.removing = false;
			itemsContainer.removeChild(item);
		}
	}
}