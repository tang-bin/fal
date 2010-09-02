/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.style.styles
{
	import fal.style.Style;
	
	import flash.text.TextFormat;
	
	public class TextStyle extends Style
	{
		private var _format:TextFormat
		
		public function get format():TextFormat
		{
			return _format;
		}
		
		public function set format(value:TextFormat):void
		{
			if(_format != value)
			{
				_format = value;
				// TODO: dispatch data change.
			}
		}
		
		public function TextStyle()
		{
			super();
			_format = new TextFormat("Verdana", 12, 0x333333);
		}
		
		public function clone():TextStyle
		{
			var ts:TextStyle = new TextStyle();
			ts.filters = this.filters;
			ts._format = this._format;
			return ts;
		}
	}
}