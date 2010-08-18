package fal.utils
{
	import fal.math.Arith;

	/**
	 * This class contains some useful string, number and characters.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class Charset
	{
		/**
		* uppercase
		*/		
		public static const UPPERCASE:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		/**
		* lowercase
		*/		
		public static const LOWERCASE:String = "abcedfghijklmnopqrstuvwxyz";
		/**
		* number in string type.
		*/		
		public static const NUMBER:String = "0123456789";
		/**
		* chars can be used as object's name in AS.
		*/		
		public static const NAME_AVAILABLE:String = "-_%$#";
		
		/**
		 * Get a random string which is maked up by lowercase.
		 * @param len Length of the string.
		 * @return 
		 * 
		 */		
		public static function getRandomString(len:Number = 10):String
		{
			var s:String = "";
			for(var i:Number = len ; --i >= 0 ; )
			{
				var index:Number = Arith.getRandomInt(0, Charset.LOWERCASE.length-1);
				s += Charset.LOWERCASE.charAt(index);
			}
			return s;
		}
		
		/**
		 * Check if the given string is accord with a avaliable name. It must be:
		 * 1, make up of letter and number and NAME_AVAILABLE character only
		 * 2, no blank in the whole string.
		 * 
		 * @param name The name of the variate.
		 * @param startWithLetter If the variate's name must start with a letter or not.
		 * 
		 * @return
		 * 
		 */		
		public static function checkVariateName(name:String, startWithLetter:Boolean = true):Boolean
		{
			if(name != "")
			{
				// check if it is begin with letter.
				if(startWithLetter)
				{
					var firstChar:String = name.charAt();
					if(!checkCharIsLetter(firstChar) && !checkCharIsNameAvailable(firstChar))
					{
						return false;
					}
				}
				//
				var checkIndex:Number = 0;
				while(name.charAt(checkIndex) != "")
				{
					var currentChar:String = name.charAt(checkIndex);
					if(!checkCharIsLetter(currentChar)
							&& !checkCharIsNumber(currentChar)
							&& !checkCharIsNameAvailable(currentChar))
					{
						return false;
					}
					checkIndex++;
				}
				return true;
			}
			// if string is ""(empty), return false.
			return false;
		}
		
		/**
		 * check out if the given string is make up of letters.
		 * 
		 * @param char
		 * @return
		 */	
		public static function checkCharIsLetter(char:String):Boolean
		{
			return checkCharIsUpperCase(char) || checkCharIsLowerCase(char);
		}
		
		/**
		 * check out if the given string is make up of uppercase.
		 * 
		 * @param char
		 * @return
		 */		
		public static function checkCharIsUpperCase(char:String):Boolean
		{
			if(char == "")
			{
				return false;
			}
			char = char.charAt();
			return Charset.UPPERCASE.indexOf(char) != -1;
		}
		
		/**
		 * check out if the given string is make up of lowercase.
		 * 
		 * @param char
		 * @return
		 * 
		 */	
		public static function checkCharIsLowerCase(char:String):Boolean
		{
			if(char == "")
			{
				return false;
			}
			char = char.charAt();
			return Charset.LOWERCASE.indexOf(char) != -1;
		}
		
		/**
		 * check out if the given character is make up of number.
		 * 
		 * @param char The given character. if it contains more than 1 character, only check the first one.
		 * @return
		 * 
		 */	
		public static function checkCharIsNumber(char:String):Boolean
		{
			if(char == "")
			{
				return false;
			}
			char = char.charAt();
			return Charset.NUMBER.indexOf(char) != -1;
		}
		
		/**
		 * Check if the given character is a name-available char.
		 * 
		 * @param char The given character
		 * @param level
		 * @return
		 */		
		public static function checkCharIsNameAvailable(char:String):Boolean
		{
			if(char == "")
			{
				return false;
			}
			char = char.charAt();
			return Charset.NAME_AVAILABLE.indexOf(char) != -1;
		}
	}
}