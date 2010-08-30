/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package
{
	import fal.debuger.Debugger;

	public function debug(...args):void
	{
		Debugger.log(args);
		trace(args);
	}
}