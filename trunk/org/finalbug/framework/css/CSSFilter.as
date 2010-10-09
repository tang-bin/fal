/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.framework.css
{
	import org.finalbug.core.data.DataModel;
	import org.finalbug.core.utils.DataUtil;
	import org.finalbug.ui.errors.StyleError;
	
	/**
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	dynamic public class CSSFilter extends DataModel
	{
		//***************************************
		//
		// DEFINE
		// 
		//***************************************/
		
		// css class typies
		public static const CLASS_TYPE:String = "classType";
		public static const ID_TYPE:String = "idType";
		public static const SELECTOR_TYPE:String = "selectorType";
		
		// style informations
		private var _type:String = "classType";
		private var _name:String = "";
		
		private var defineList:Object = new Object();
		
		//***************************************
		// 
		// GETTER & SETTER
		// 
		//***************************************/
		
		//***************************************
		// 
		// constructor.
		// 
		//***************************************/
		public function CSSFilter(name:String = "", type:String = "classType")
		{
			super();
			var typeIndex:uint = DataUtil.match(type, [CLASS_TYPE, ID_TYPE, SELECTOR_TYPE]);
			if(typeIndex == -1)
			{
				throw new StyleError(StyleError.CSS_TYPE_ERROR);
			}
			else
			{
				_name = name;
				_type = type;
			}
		}
		
		//***************************************
		// 
		// OVERRIDE METHODS
		// 
		// Whit out getter, setter and handler
		// include public, protected and private.
		// 
		//***************************************/
		
		//***************************************
		// 
		// PUBLIC
		// 
		//***************************************/
		
		public function addStyle(name:String, value:String):void
		{
			defineList[name] = value;
		}
		
		public function getStyle(name:String):String
		{
			if(defineList[name] == null) return "";
			else return defineList[name];
		}
		
		public function removeStyle(name:String):void
		{
			if(defineList[name] != null)
			{
				delete defineList[name];
				defineList[name] = null;
			}
		}
		
		//***************************************
		// 
		// PROTECTED
		// 
		//***************************************/
		
		//***************************************
		// 
		// PRIVATE
		// 
		//***************************************/
		
		//***************************************
		// 
		// HANDLER
		// 
		//***************************************/
	}
}