package ovrkm.scroll.pane.elements
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class Content extends Sprite
	{
		public function Content()
		{
			super();
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(500, 500, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			
			graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0x0000FF], [1,1], [0, 255], matr, spreadMethod);
			graphics.drawRect(0,0,500,500);
			graphics.endFill();
		}
	}
}