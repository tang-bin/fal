/******************************************
* [fb-aslib] Finalbug ActionScript Library
* http://www.finalbug.org/
******************************************/
package org.finalbug.debugger
{
	import org.finalbug.utils.StringUtil;

	public class Debug
	{
		public static var debugger:Debugger;
		
		public static function log(...args):void
		{
			if(debugger != null) debugger.log(StringUtil.getLogStringFromArray(args));
		}
	}
}
