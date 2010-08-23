/*****************************************
 * Finalbug ActionScript Library ( http://www.finalbug.org/ )
 * 
 * fal.css.CSSStyle
 *
 * @author Tang Bin (tangbin@finalbug.org)
 * @since Jul 12, 2010 11:04:52 PM
 *
 *****************************************/
package fal.style
{
	import fal.data.DataModel;
	import fal.errors.FALError;
	import fal.style.styles.FillStyle;
	import fal.style.styles.LayoutStyle;
	import fal.style.styles.Style;
	import fal.style.styles._fillStyle;
	import fal.style.styles._layoutStyle;
	import fal.utils.DataAnt;
	
	import flash.display.DisplayObject;
	
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
		
		private var _layoutStyle:_layoutStyle = new _layoutStyle();
		private var _fillStyle:_fillStyle = new _fillStyle();
		
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
		
		public function get fillStyle():FillStyle
		{
			return _fillStyle;
		}
		
		//***************************************
		// 
		// fal.css.CSSData constructor.
		// 
		//***************************************/
		public function CSSStyle(name:String, type:String = "classType")
		{
			super();
			var typeIndex:uint = DataAnt.match(type, [CLASS_TYPE, ID_TYPE, SELECTOR_TYPE]);
			if(name == null || name == "")
			{
				throw new Error(FALError.NAME_NULL);
			}
			else if(typeIndex == -1)
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