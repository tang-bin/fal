/****************************
 * org.finalbug.core.errors.MotionError
 *
 * @author Tang Bin
 * @since 2010-10-14
 ****************************/
package org.finalbug.errors
{
	public class MotionError extends Error
	{
		public static const START_END_NOT_MATCH:String = "Counts of start values and end values must the same.";
		
		public static const COUNT_VALUE_NOT_NUMBER:String = "Count value mast be number";
		
		public function MotionError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}