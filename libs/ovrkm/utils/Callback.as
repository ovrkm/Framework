package ovrkm.utils
{
	public class Callback
	{
		public var onResult:Function;
		public var onFault:Function;
		
		public function Callback(onResult:Function=null, onFault:Function=null)
		{
			this.onResult = onResult;
			this.onFault = onFault;
		}
	}
}