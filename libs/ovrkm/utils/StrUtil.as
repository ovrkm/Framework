/**
 * Created by IntelliJ IDEA.
 * User: Krasnov
 * Date: 15.06.11
 * Time: 15:31
 * To change this template use File | Settings | File Templates.
 */
package ovrkm.utils
{

	public class StrUtil
	{
		public static function hexStringToNumber(hexStr:String):Number
		{
			if (hexStr.charAt(0) == "#" && hexStr.length > 7)
			{
				return Number("*"); // NaN;
			}
			if (hexStr.charAt(0) != "#" &&
					hexStr.length > 6
					)
			{
				return Number("*"); // NaN;
			}

			var newStr:String;

			if (hexStr.charAt(0) == "#")
			{
				newStr = hexStr.substr(1, hexStr.length);
			}
			else
			{
				newStr = hexStr;
			}

			if (newStr.length < 6)
			{
				var z:String = "000000";
				// add zeros to the string to make it 6 characters long
				newStr = newStr + z.substr(0, z.length - newStr.length);
			}
			var numStr:String = "0x" + newStr;
			var num:Number = Number(numStr);
			return num;
		}
	}
}
