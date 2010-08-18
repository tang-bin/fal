package fal.utils
{
	
	/******************************************
	 * Finalbug's ActionScript ( http://www.finalbug.org/ )
	 * 
	 * fal.utils.DataAnt
	 *
	 * @author Tang Bin (tangbin@finalbug.org)
	 * @since Jul 13, 2010 8:04:38 PM
	 *
	 *****************************************/
	public class DataAnt
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		/****************************************
		 * fal.utils.DataAnt constructor.
		 ****************************************/
		public function DataAnt()
		{
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		/**
		 * check if the value target is in the list of values.
		 * 
		 * @param target
		 * @param args
		 * @return Return the index of values in array list if target is found, or -1 if is not found
		 * 
		 */		
		public static function match(target:*, values:Array):int
		{
			for(var i:uint = values.length ; --i >= 0 ; )
			{
				if(values[i] == target)return i;
			}
			return -1;
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}