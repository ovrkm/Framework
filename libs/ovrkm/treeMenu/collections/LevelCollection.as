package ovrkm.treeMenu.collections
{
	import ovrkm.treeMenu.AbstractItem;
	import ovrkm.data.Collection;

	public class LevelCollection extends Collection
	{
		public var anchorItem:AbstractItem;
		
		public function LevelCollection(items:Array, anchorItem:AbstractItem)
		{
			this.anchorItem = anchorItem;
			super(items);
		} 
	}
}