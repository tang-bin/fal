package fal.utils 
{
	/**
	 * ...
	 * @author Finalbug
	 */
	public class DataChecker
	{
		public static function allNotNull(array:Array):Boolean
		{
			for (var i:int = array.length ; --i >= 0 ; )
			{
				if (array[i] == null)
				{
					return false;
				}
			}
			return true;
		}
	}
}