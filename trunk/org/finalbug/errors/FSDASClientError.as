/******************************************
 * [fb-aslib] Finalbug ActionScript Library 
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.errors
{
	public class FSDASClientError extends Error
	{
		public static const ALREADY_LISTEN:String = "alreadyListen";
		
		public function FSDASClientError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}