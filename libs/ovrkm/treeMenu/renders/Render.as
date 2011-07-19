package ovrkm.treeMenu.renders
{
	import ovrkm.treeMenu.AbstractItem;
	import ovrkm.treeMenu.TreeMenu;
	import ovrkm.treeMenu.collections.ItemsCollection;
	import ovrkm.treeMenu.collections.LevelCollection;
	import ovrkm.data.Collection;
	
	import flash.events.EventDispatcher;

	public class Render extends EventDispatcher
	{
		private var _items:ItemsCollection;
		private var _items2Add:ItemsCollection;
				
		protected var currentAnchorItem:AbstractItem;
		protected var menu:TreeMenu;
		
		public function Render(levels:Array, menu:TreeMenu)
		{
			_items = new ItemsCollection();
			_items2Add = new ItemsCollection();
			
			this.menu = menu;
			
			_processLevels(levels);
		}
		
		private function _processLevels(levels:Array):void
		{
			var level:LevelCollection;
			for(var i:uint = 0; level = levels[i] as LevelCollection; i++) _processLevel(level, i);
		}
		
		private function _processLevel(level:LevelCollection, levelIndex:uint):void
		{
			var item:AbstractItem;
			var prevItem:AbstractItem;
			
			currentAnchorItem = level.anchorItem;
			
			for(var i:uint = 0; item = level.getItemAt(i) as AbstractItem; i++)
			{
				_items.addItem(item);
				
				if(item.added) continue;
				
				_items2Add.addItem(item);
				processAddItem(levelIndex, item, prevItem);
				
				prevItem = item;
			}
		}
		
		protected function processAddItem(levelIndex:uint, item:AbstractItem, prevItem:AbstractItem):void
		{
			trace("need to override - processAddItem");
		}
		
		public function change(anim:Boolean):void
		{
			trace("need to override - change");
		}
		
		public function getItems2Add():ItemsCollection
		{
			return _items2Add;
		}
		
		public function getItems2Remove():ItemsCollection
		{
			var items2Remove:ItemsCollection = new ItemsCollection();
			
			var i:uint;
			var item:AbstractItem;
			
			for(i = 0; item = menu.items.getItemAt(i) as AbstractItem; i++)
			{
				if(item.added && !item.removing) 
				{
					if(!getItems().containsItem(item))
					{
						items2Remove.addItem(item);
						item.removing = true;
					}
				}
			}
			
			return items2Remove;
		}
		
		public function getItems():ItemsCollection
		{
			return _items;
		}
	}
}