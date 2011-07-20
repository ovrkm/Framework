/**
 * Created by IntelliJ IDEA.
 * User: Krasnov
 * Date: 19.07.11
 * Time: 16:56
 * To change this template use File | Settings | File Templates.
 */
package framework.view
{
	import framework.controller.Controller;
	import framework.model.Model;

	public interface IViewComponent
	{
		function inject(m:Model, c:Controller):void
	}
}
