package ovrkm.data
{
	import flash.utils.getQualifiedClassName;

	public class Collection
	{
		private var _items:Array;
		
		public function Collection(items:Array = null)
		{
			this._items = items ? items : [] ;
		}
		
		public function containsItem(item:Object):Boolean
		{
			var itm:Object;
			
			for(var i:uint = 0; itm = getItemAt(i) ; i++)
				if(itm == item) return true;
			
			return false;
		}
		
		public function addItem(item:Object):void
		{
			_items.push(item);
		}
		
		public function replaceItemAt(item:Object, index:uint):Object
		{
			var item:Object = _items[index];
			
			_items[index] = item;
			
			return item;
		}
		
		public function removeItem(item:Object):Object
		{
			var out:Object;
			var itm:Object;
			
			for(var i:uint = 0; itm = getItemAt(i); i++)
			{
				if(item == itm)
				{
					out = item;
					_items.splice(i,1);
					break;
				}
			}
			
			return out;
		}
		
		public function removeItemAt(index:uint):Object
		{
			return _items.splice(index, 1) as Object;
		}
		
		public function getItemAt(index:int):Object
		{
			return _items[index] as Object;
		}
		
		public function getItemsCount():uint
		{
			return _items.length;
		}
		
		public function getArray():Array
		{
			return _items;
		}
		
		public function toString():String
		{
			return "[object " + getQualifiedClassName(this) + " items=" + getItemsCount() + "]";
		}
	}
}