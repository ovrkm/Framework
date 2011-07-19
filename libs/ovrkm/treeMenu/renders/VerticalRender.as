package ovrkm.treeMenu.renders
{
	import ovrkm.treeMenu.AbstractItem;
	import ovrkm.treeMenu.TreeMenu;
	import ovrkm.treeMenu.collections.ItemsCollection;
	import ovrkm.data.Collection;
	
	import com.greensock.TweenMax;
	
	import flash.geom.Rectangle;

	public class VerticalRender extends Render
	{
		private var ITEM_GAP:Number = 0;
		
		public function VerticalRender(levels:Array, menu:TreeMenu)
		{
			super(levels, menu);
		}
		
		override protected function processAddItem(levelIndex:uint, item:AbstractItem, prevItem:AbstractItem):void
		{
			if(levelIndex == 0)
			{
				if(prevItem) item.x = prevItem.x + prevItem.width + ITEM_GAP;
			}
			else if(levelIndex == 1)
			{
				item.x = currentAnchorItem.x;
				
				if(prevItem) item.y = prevItem.y + prevItem.height + ITEM_GAP;
				else item.y = currentAnchorItem.y + currentAnchorItem.height + ITEM_GAP;
			}
			else
			{
				item.x = currentAnchorItem.x + currentAnchorItem.width;
				
				if(prevItem) item.y = prevItem.y + prevItem.height + ITEM_GAP;
				else item.y = currentAnchorItem.y;
			}
		}
		
		private function drawZone() : void
		{
			menu.closeZone.clear();
			
			var item:AbstractItem;
			var itemBounds:Rectangle;
			
			for(var i:uint = 0; item = getItems().getItemAt(i) as AbstractItem; i++)
			{
				itemBounds = item.getBounds(menu.closeZone);
				itemBounds.inflate(ITEM_GAP*2, ITEM_GAP*2);
				itemBounds.offset(-ITEM_GAP, -ITEM_GAP);
				menu.closeZone.draw(itemBounds);
			}
		}
		
		override public function change(anim:Boolean):void
		{
			var items2Add:ItemsCollection = getItems2Add();
			
			// add items
			if(items2Add.getItemsCount())
			{
				// draw zone
				drawZone();
				
				var addTime:Number = anim ? .2 : 0 ;
				
				menu.addItems(items2Add);
				_animAddedItems = items2Add;
				_animAddedItems.blockItems(true);
				
				var addedItemsBounds:Rectangle = _animAddedItems.getBounds(menu.itemsContainer);
				
				TweenMax.allFromTo(items2Add.getArray(), addTime, {alpha:0, y:"-" + addedItemsBounds.height}, {alpha:1, y:"" + addedItemsBounds.height}, 0, _animAddComplete);
			}
			
			// remove items
			var removeTime:Number = anim ? .2 : 0 ;
			var items2Remove:ItemsCollection = getItems2Remove();
			
			TweenMax.allTo(items2Remove.getArray(), removeTime, {alpha:0}, 0, _animRemoveComplete, [items2Remove]);
		}
		
		private var _animAddedItems:ItemsCollection;
		private function _animAddComplete():void
		{
			_animAddedItems.blockItems(false);
		}
		
		private function _animRemoveComplete(items:ItemsCollection):void
		{
			menu.removeItems(items);
			drawZone();
		}
	}
}