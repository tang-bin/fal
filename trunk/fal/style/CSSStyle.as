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
		
		private var layoutStyle:LayoutStyle = new LayoutStyle();
		private var fillStyle:FillStyle = new FillStyle();
		
		//***************************************
		// 
		// GETTER & SETTER
		// 
		//***************************************/
		
		// for fill style.
		public function get borderColor():Number{return fillStyle.borderColor;}
		public function set borderColor(value:Number):void{fillStyle.borderColor = value;}
		
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
			if(layoutStyle.setStyle(name, value)){}
			else this[name] = value;
		}
		
		public function getWidth(parent:DisplayObject):Number
		{
			return layoutStyle.getWidth(parent);
		}
		
		public function getWidthBySize(parentWidth:Number):Number
		{
			return layoutStyle.getWidthBySize(parentWidth);
		}
		
		public function getHeight(parent:DisplayObject):Number
		{
			return layoutStyle.getHeight(parent);
		}
		
		public function getHeightBySize(parentHeight:Number):Number
		{
			return layoutStyle.getHeightBySize(parentHeight);
		}
		
		public function getX(parent:DisplayObject):Number
		{
			return layoutStyle.getX(parent);
		}
		
		public function getXBySize(parentWidth:Number):Number
		{
			return layoutStyle.getXBySize(parentWidth);
		}
		
		public function getY(parent:DisplayObject):Number
		{
			return layoutStyle.getY(parent);
		}
		
		public function getYBySize(parentHeight:Number):Number
		{
			return layoutStyle.getYBySize(parentHeight);
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