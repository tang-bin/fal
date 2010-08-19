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
	
	import flash.display.DisplayObject;
	
	public class CSSStyle extends DataModel
	{
		//***************************************
		//
		// DEFINE
		// 
		//***************************************/
		
		private const reg1:RegExp = /^(\d*\.?\d*)$/;
		private const reg2:RegExp = /^(\d*\.?\d*)%$/;
		
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
		private var _width:String = "";
		private var _height:String = "";
		private var _left:String = "";
		private var _right:String = "";
		private var _top:String = "";
		private var _bottom:String = "";
		// addtion position and size attributes
		private var _horizontal:String = "";
		private var _vertical:String = "";
		
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
		
		public function getWidth(parent:DisplayObject):Number
		{
			return getWidthBySize(parent.width);
		}
		
		public function getWidthBySize(parentWidth:Number):Number
		{
			if(validValue(_width))
			{
				return getValue(_width, parentWidth);
			}
			else if(validValue(_left) && validValue(_right))
			{
				return parentWidth - getValue(_left, parentWidth) - getValue(_right, parentWidth);
			}
			else
			{
				return 0;
			}
		}
		
		public function getHeight(parent:DisplayObject):Number
		{
			return getHeightBySize(parent.height);
		}
		
		public function getHeightBySize(parentHeight:Number):Number
		{
			if(validValue(_height))
			{
				return getValue(_height, parentHeight);
			}
			else if(validValue(_top) && validValue(_bottom))
			{
				return parentHeight - getValue(_top, parentHeight) - getValue(_bottom, parentHeight);
			}
			else
			{
				return 0;
			}
		}
		
		public function getX(parent:DisplayObject):Number
		{
			return getXBySize(parent.width);
		}
		
		public function getXBySize(parentWidth:Number):Number
		{
			if(validValue(_left))
			{
				return getValue(_left, parentWidth);
			}
			else if(validValue(_right) && validValue(_width))
			{
				return parentWidth - getValue(_right, parentWidth) - getValue(_width, parentWidth);
			}
			else if(validValue(_width) && validValue(_horizontal))
			{
				return (parentWidth - getValue(_width, parentWidth)) / 2 + getValue(_horizontal);
			}
			else
			{
				return 0;
			}
		}
		
		public function getY(parent:DisplayObject):Number
		{
			return getYBySize(parent.width);
		}
		
		public function getYBySize(parentHeight:Number):Number
		{
			if(validValue(_top))
			{
				return getValue(_top, parentHeight);
			}
			else if(validValue(_bottom) && validValue(_height))
			{
				return parentHeight - getValue(_bottom, parentHeight) - getValue(_height, parentHeight);
			}
			else if(validValue(_height) && validValue(_vertical))
			{
				return (parentHeight - getValue(_height, parentHeight)) / 2 + getValue(_vertical);
			}
			else
			{
				return 0;
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
		
		private function validValue(str:String):Boolean
		{
			return (reg1.exec(str) || reg2.exec(str));
		}
		
		private function getValue(valueStr:String, parentValue:Number = 0):Number
		{
			if(reg1.exec(valueStr))
			{
				return Number(valueStr);
			}
			else if(reg2.exec(valueStr))
			{
				var p:Number = Number(valueStr.replace(reg2, "$1"));
				p = p / 100;
				return parentValue * p;
			}
			else
			{
				return 0;
			}
		}
		
		//***************************************
		// 
		// HANDLER
		// 
		//***************************************/
	}
}