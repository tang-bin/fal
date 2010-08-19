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
	import fal.utils.DataAnt;
	
	public class CSSStyle extends DataModel
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
		
		// errors
		private const NAME_NULL:String = "parameter name cannot be null or empty.";
		private const TYPE_ERROR:String = "parameter type must be one of the following " +
			"values:classType, idType, selectorType.";
		
		// style informations
		private var _type:String = "classType";
		private var _name:String = "";
		
		private var useGradientBg:Boolean = false;
		
		// ********************************
		// 
		// style attributes
		// 
		// **************************
		// position and size
		private var _width:String = "0";
		private var _height:String = "0";
		private var _left:String = "0";
		private var _right:String = "0";
		private var _top:String = "0";
		private var _bottom:String = "0";
		// addtion position and size attributes
		private var _horizontal:String = "0";
		private var _vertical:String = "0";
		
		// **************************
		// fill style
		private var _borderColor:String = "#333333";
		private var _borderAlpha:String = "0.1";
		private var _backgroundColor:String = "#FFFFFF";
		private var _backgroundAlpha:String = "0.1";
		// addtion fill style
		private var _topLeftRadius:String = "0";
		private var _topRightRadius:String = "0";
		private var _bottomLeftRadius:String = "0";
		private var _bottomRightRadius:String = "0";
		private var _radius:String = "0";
		
		private var _gradientBackgroundColors:String = "#333, #FFF";
		private var _gradientBackgroundAlphas:String = "1, 1";
		private var _gradientBackgroundRotation:String = "0";
		
		// **************************
		// 
		// filter attributes
		// 
		// **************************
		// skin attributes
		
		
		//***************************************
		// 
		// GETTER & SETTER
		// 
		//***************************************/
		
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
				throw new Error(NAME_NULL);
			}
			else if(typeIndex == -1)
			{
				throw new Error(TYPE_ERROR);
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
			if(this.hasOwnProperty("_" + name))
			{
				this["_" + name] = value;
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