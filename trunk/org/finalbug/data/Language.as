//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################

package org.finalbug.data
{
	import flash.system.Capabilities;
	
	import org.finalbug.utils.DataUtil;
	
	/**
	 * Language
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */	
	public class Language extends DataModel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public static var OK:String = "OK";
		/**
		 * 
		 * @default 
		 */
		public static var Yes:String = "Yes";
		/**
		 * 
		 * @default 
		 */
		public static var No:String = "No";
		/**
		 * 
		 * @default 
		 */
		public static var cancel:String = "Cancel";
		
		private static var _type:String = "en";
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public static function get type():String
		{
			return type
		}
		/**
		 * 
		 * @param value
		 */
		public static function set type(value:String):void
		{
			if(!DataUtil.included(value, "zh-CN", "en"))
			{
				value = "en";
			}
			if(value != _type)
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
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function Language()
		{
			super();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param type
		 * @return 
		 */
		public static function getLanguageName(type:String):String
		{
			switch(type)
			{
				case "zh-CN":return "简体中文";break;
				case "en":return "English";break;
				default: return "Unknown";break;
			}
			return null;
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}
