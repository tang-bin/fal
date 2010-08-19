/****************************
 * .GlobalMethods
 *
 * @author Tang Bin
 * @since 2010-8-18
 ****************************/
package
{
	import fal.debuger.Debugger;

	public function debug(...args):void
	{
		Debugger.log(args);
		trace(args);
	}
}