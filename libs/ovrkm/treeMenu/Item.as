package ovrkm.treeMenu
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import ovrkm.treeMenu.AbstractItem;
	
	// typical item
	
	public class Item extends AbstractItem
	{
		public var nameText:TextField;
		
		public function Item()
		{
			super();
			
			nameText = new TextField();
			nameText.autoSize = TextFieldAutoSize.LEFT;
			nameText.selectable = false;
			
			var tf:TextFormat = new TextFormat("Arial", 6);
			nameText.defaultTextFormat = tf;
			
			addChild(nameText);
		}
		
		public function setTitle(text:String):void
		{
			nameText.text = text;
		}
	}
}