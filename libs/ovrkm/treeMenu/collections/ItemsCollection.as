package ovrkm.treeMenu.collections
{
	import ovrkm.treeMenu.AbstractItem;
	import ovrkm.utils.PathUtil;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import ovrkm.data.Collection;

	public class ItemsCollection extends Collection
	{
		public function ItemsCollection(items:Array = null)
		{
			super(items);
		}
		
		public function getItemsByParentID(parentID:String=""):Array
		{
			var out:Array = [];
			var item:AbstractItem;
			var itemParentID:String;
			
			for(var i:uint = 0; item = getItemAt(i) as AbstractItem; i++)
			{
				itemParentID = PathUtil.getParentID(item.id);
				if(itemParentID == parentID) out.push(item);
			}
			
			return out;
		}
		
		public function getLevels(id:String):Array
		{
			var levels:Array = [];
			var anchorItemIDs:Array = PathUtil.getItemsHierarhy(id);
			var anchorID:String;
			
			for(var i:uint = 0; i < anchorItemIDs.length ; i++)
			{  
				anchorID = anchorItemIDs[i];
				levels.push(new LevelCollection(getItemsByParentID(anchorID), getItemByID(anchorID)));
			}
			
			return levels;
		}
		
		public function getItemByID(id:String):AbstractItem
		{
			var out:AbstractItem;
			var item:AbstractItem;
			
			for(var i:uint = 0; item = getItemAt(i) as AbstractItem; i++)
			{
				if(item.id == id)
				{
					out = item;
					break;
				}
			}
			
			return out;
		}
		
		public function blockItems(value:Boolean):void
		{
			var item:AbstractItem;
			
			for(var i:uint = 0; item = getItemAt(i) as AbstractItem; i++)
				item.block = value;
		}
		
		public function getBounds(parent:DisplayObject):Rectangle
		{
			var out:Rectangle;
			var item:AbstractItem;
			var itemBounds:Rectangle;
			
			for(var i:uint = 0; item = getItemAt(i) as AbstractItem; i++)
			{
				itemBounds = item.getBounds(parent);
				
				if(!out) out = itemBounds;
				else out = out.union(itemBounds);
			}
			
			return out;
		}
	}
}