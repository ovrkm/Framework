package ovrkm.components
{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class DisplayText extends BaseComponent
	{
		public var field:TextField;
		
		public var fieldRectangle:Rectangle;
		public var currentTextSize:Number;
		
		public function DisplayText()
		{
			super();
			
			fieldRectangle = field.getBounds(this);
		}
		
		public function setText(text:String):void
		{
			field.text = text;
		}
		
		public function getText():String
		{
			return field.text;
		}
		
		public function setHTMLText(text:String):void
		{
			field.htmlText = text;
		}
		
		public function insertText(htmlText:String, maxSize:Number, middle:Boolean=false):void
		{
			field.autoSize = TextFieldAutoSize.CENTER;
			
			do
			{
				currentTextSize = maxSize;
				field.htmlText = "<font size='" + maxSize-- + "'>" + htmlText + "</font>"
			}
			while(field.height > fieldRectangle.height)
			
			
			field.autoSize = TextFieldAutoSize.NONE;
			if(middle) field.y = fieldRectangle.y + (fieldRectangle.height-field.height)/2 - 2;
		}
	}
}