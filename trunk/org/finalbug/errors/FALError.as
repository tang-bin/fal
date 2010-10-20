/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.errors
{
	/****************************
	 * errors.FALError
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 ****************************/
	public class FALError extends Error
	{
		public static const SINGLETON:String = "Class using singleton pattern cannot be instanced.";
		public static const NAME_EXIST:String = "The name of this data already exist.";
		public static const NAME_NOT_EXIST:String = "Object not exist.";
		
		public function FALError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}