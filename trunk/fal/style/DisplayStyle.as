/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.style
{
	import fal.data.DataModel;
	import fal.style.styles.FillStyle;
	import fal.style.styles.LayoutStyle;
	import fal.style.styles.TextStyle;
	
	import flash.display.DisplayObject;
	
	/**
	 * fal.style.DisplayStyle
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.09
	 */	
	public class DisplayStyle extends DataModel
	{
		//***************************************
		//
		// DEFINE
		// 
		//***************************************/
		
		private var _layoutStyle:LayoutStyle = new LayoutStyle();
		private var _fillStyle:FillStyle = new FillStyle();
		private var _textStyle:TextStyle = new TextStyle();
		
		private var styleList:Array = [
			_layoutStyle,
			_fillStyle,
			_textStyle
		];
		
		private var _owner:DisplayObject;
		
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
		
		public function get textStyle():TextStyle
		{
			return _textStyle;
		}
		public function set textStyle(value:TextStyle):void
		{
			if(_textStyle != value)
			{
				_textStyle = value;
				// TODO: dispatch style changed.
			}
		}
		
		public function get owner():DisplayObject
		{
			return _owner;
		}
		public function set owner(value:DisplayObject):void
		{
			if(_owner != value)
			{
				_owner = value;
				for each(var s:Style in styleList)
				{
					s.owner = _owner;
				}
			}
		}
		
		//***************************************
		// 
		// constructor.
		// 
		//***************************************/
		public function DisplayStyle()
		{
			super();
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
		
		public function addCSSFilter(filter:CSSFilter):void
		{
			for each(var style:Style in this.styleList)
			{
				style.addCSSFilter(filter);
			}
		}
		
		public function removeCSSFilter(filter:CSSFilter):void
		{
			for each(var style:Style in this.styleList)
			{
				style.removeCSSFilter(filter);
			}
		}
		
		public function clone():DisplayStyle
		{
			var ds:DisplayStyle = new DisplayStyle();
			ds.fillStyle = this._fillStyle.clone();
			ds.layoutStyle = this._layoutStyle.clone();
			ds.textStyle = this._textStyle.clone();
			return ds;
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