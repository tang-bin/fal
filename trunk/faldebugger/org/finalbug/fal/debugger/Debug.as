/******************************************
* Finalbug ActionScript Library
* http://www.finalbug.org/
******************************************/
package org.finalbug.fal.debugger
{
	public class Debug
	{
		public static var debugger:Debugger;
		
		public static function log(...args):void
		{
			debugger.log(args);
		}
	}
}
