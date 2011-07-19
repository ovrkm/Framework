package ovrkm.utils
{
	// for path like "item1/item2/item3" 
	public class PathUtil
	{
		public static function getItemsHierarhy(id:String, desc:Boolean=false):Array
		{
			var out:Array = [];
			
			var parentID:String = id;
			
			while(true)
			{
				out.push(parentID);
				
				if(parentID == "") break;
				
				parentID = getParentID(parentID);
			}
			
			if(!desc) out = out.reverse();
			
			return out;
		}
		
		public static function getParentID(id:String):String
		{
			var path:Array = id.split("/");
			var parentID:String = path.length > 1 ? path.slice(0, [path.length-1]).join("/") : "";
			
			return parentID;
		}
		
		public static function getPathFromXML(node:XML, nodeName:String, rootNodeName:String):String
		{
			var path:String = "";
			
			while(node.name() != rootNodeName)
			{
				path = "/" + node[nodeName] + path;
				
				node = node.parent();
			}
			
			path = path.substr(1);
			
			return path;
		}
		
		public static function getLevelByPath(path:String):uint
		{
			return path.split("/").length-1;
		}
		
		public static function normalizePath(path:String):String
		{
			var pathNamesArr:Array = path.split("/");
			var pathStr:String = "";
			
			for each(var pathName:String in pathNamesArr)
			{
				if(pathName == "") continue;
				pathStr += "/" + pathName;
			}
			
			return pathStr;
		}
		
		public static function getPathArray(path:String):Array
		{
			path = normalizePath(path);
			
			var pathArr:Array = path.split("/");
			
			pathArr.shift();
			
			return pathArr;
		}
		
	}
}