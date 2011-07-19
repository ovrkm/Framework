package ovrkm.scroll.engines
{
	import flash.display.DisplayObject;

	public interface IScrollEngine
	{
		function get track():DisplayObject;
		function get drag():DisplayObject;
		function get content():DisplayObject;
		function get contentMask():DisplayObject;

		function get position():Number;
		function set position(value:Number):void;
	}
}