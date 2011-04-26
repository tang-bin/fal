// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.data
{
	import ftk.errors.DataError;
	import ftk.utils.DataUtil;

	/**
	 * Language defines usual language strings and language type.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	/**
	 * 
	 * @author lenovo
	 */
	public class Language extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default OK
		 */
		public static var OK:String = "OK";

		/**
		 * 
		 * @default Yes
		 */
		public static var Yes:String = "Yes";

		/**
		 * 
		 * @default No
		 */
		public static var No:String = "No";

		/**
		 * 
		 * @default Cancel
		 */
		public static var cancel:String = "Cancel";

		private static var _type:String = "en";

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @return 
		 */
		public static function get type():String
		{
			return type;
		}

		/**
		 * 
		 * @param value
		 */
		public static function set type(value:String):void
		{
			if (!DataUtil.included(value, "zh-CN", "en"))
			{
				value = "en";
			}
			if (value != _type)
			{
				_type = value;
				switch(_type)
				{
					case "en":
						OK = "OK";
						Yes = "Yes";
						No = "No";
						cancel = "Cancel";
						break;
					case "zh-CN":
						OK = "确定";
						Yes = "是";
						No = "否";
						cancel = "取消";
						break;
				}
			}
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @throws DataError Throw DataError.STATIC_CLASS error when try to
		 * instance Language object.
		 * Language is static class, cannot be instanced.
		 */
		public function Language()
		{
			throw new DataError(DataError.STATIC_CLASS);
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @param type
		 * @return 
		 */
		public static function getLanguageName(type:String):String
		{
			switch(type)
			{
				case "zh-CN":
					return "简体中文";
					break;
				case "en":
					return "English";
					break;
				default:
					return "Unknown";
					break;
			}
			return null;
		}
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}
