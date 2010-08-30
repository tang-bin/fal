/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.css
{
	import fal.data.DataModel;
	import fal.errors.FALError;
	import fal.css.styles.FillStyle;
	import fal.css.styles.LayoutStyle;
	import fal.css.styles.Style;
	import fal.utils.DataUtil;
	
	dynamic public class CSSStyle extends DataModel
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
		
		private var useGradientBg:Boolean = false;
		
		private var _layoutStyle:LayoutStyle = new LayoutStyle();
		private var _fillStyle:FillStyle = new FillStyle();
		
		private var styleList:Array = [_layoutStyle, _fillStyle];
		
		//***************************************
		// 
		// GETTER & SETTER
		// 
		//***************************************/
		
		public function get layoutStyle():LayoutStyle
		{
			return _layoutStyle;
		}
		public function set layoutStyle(value:LayoutStyle):void
		{
			_layoutStyle = value;
			// TODO : dispatch style changed.
		}
		
		public function get fillStyle():FillStyle
		{
			return _fillStyle;
		}
		public function set fillStyle(value:FillStyle):void
		{
			_fillStyle = value;
			// TODO : dispatch style changed.
		}
		
		//***************************************
		// 
		// fal.css.CSSData constructor.
		// 
		//***************************************/
		public function CSSStyle(name:String = "", type:String = "classType")
		{
			super();
			var typeIndex:uint = DataUtil.match(type, [CLASS_TYPE, ID_TYPE, SELECTOR_TYPE]);
			if(typeIndex == -1)
			{
				throw new Error(FALError.CSS_TYPE_ERROR);
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
			if(_layoutStyle.setStyle(name, value)){}
			else this[name] = value;
		}
		
		public function getStyle(name:String):String
		{
			for each(var style:Style in styleList)
			{
				var str:String = style.getStyle(name);
				if(str != "")
				{
					return str;
				}
			}
			return "";
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