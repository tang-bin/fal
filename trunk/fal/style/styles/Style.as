/****************************
 * fal.style.styles.Style
 *
 * @author Tang Bin
 * @since 2010-8-20
 ****************************/
package fal.style.styles
{
	import fal.data.DataModel;
	
	public class Style extends DataModel
	{
		public static const NUM_REG:RegExp = /^(-?\d*\.?\d*)$/;
		public static const PERCENT_REG:RegExp = /^(-?\d*\.?\d*)%$/;
		
		public function Style()
		{
			super();
		}
		
		public function setStyle(styleName:String, styleValue:String):Boolean
		{
			if(this.hasOwnProperty(styleName))
			{
				this[styleName] = styleValue;
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function getStyle(name:String):String
		{
			if(this.hasOwnProperty(name))
			{
				return this[name].toString();
			}
			else
			{
				return "";
			}
		}
		
		public function validLayoutValue(str:String):Boolean
		{
			return (Style.NUM_REG.exec(str) || Style.PERCENT_REG.exec(str));
		}
		
		public function getLayoutValue(valueStr:String, parentValue:Number = 0):Number
		{
			if(Style.NUM_REG.exec(valueStr))
			{
				return Number(valueStr);
			}
			else if(Style.PERCENT_REG.exec(valueStr))
			{
				var p:Number = Number(valueStr.replace(Style.PERCENT_REG, "$1"));
				p = p / 100;
				return parentValue * p;
			}
			else
			{
				return 0;
			}
		}
	}
}