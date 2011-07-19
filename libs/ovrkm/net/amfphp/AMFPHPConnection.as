/**
 * Created by IntelliJ IDEA.
 * User: ovrkm
 * Date: 05.03.11
 * Time: 20:30
 * To change this template use File | Settings | File Templates.
 */
package ovrkm.net.amfphp
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;

	[Event(name="success", type="ovrkm.net.amfphp.ConnectionEvent")]
	[Event(name="fault", type="ovrkm.net.amfphp.ConnectionEvent")]
	public class AMFPHPConnection extends EventDispatcher
	{
		private var service:NetConnection;

		public function AMFPHPConnection(service:NetConnection)
		{
			this.service = service;
		}

		public function call(methodName:String, ... args):void
		{
			var responder:Responder = new Responder(resultSuccessHandler, resultFaultHandler);

			var callArgs:Array = [methodName, responder];
			callArgs = callArgs.concat(args);

			service.call.apply(this, callArgs);
		}

		private function resultSuccessHandler(result:Object):void
		{
			var connectionEvent:ConnectionEvent = new ConnectionEvent(ConnectionEvent.SUCCESS);
			connectionEvent.result = result;
			dispatchEvent(connectionEvent);
		}

		private function resultFaultHandler(result:Object):void
		{
			var connectionEvent:ConnectionEvent = new ConnectionEvent(ConnectionEvent.FAULT);
			connectionEvent.result = result;
			dispatchEvent(connectionEvent);
		}
	}
}
