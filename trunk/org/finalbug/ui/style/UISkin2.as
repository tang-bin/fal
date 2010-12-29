/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/ 
package org.finalbug.ui.style
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import org.finalbug.data.DataModel;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.glazes.Scale9Bitmap;
	
	/**
	 * UISkin
	 * 
	 * @author Tang Bin
	 * @since 2010.09
	 */	
	public class UISkin2 extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************
		
		private var _fillStyle:FillStyle = new FillStyle();
		private var _textStyle:TextStyle = new TextStyle();
		
		private var styleList:Array = [_fillStyle, _textStyle];
		
		private var _bitmapSkin:Bitmap
		
		private var _owner:DisplayObject;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
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
		
		public function get bitmapSkin():Bitmap
		{
			return this._bitmapSkin;
		}
		
		//***************************************
		// Constructor.
		//***************************************
		public function UISkin2()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function setBitmapSkin(bitmap:Bitmap, scale9:Rectangle = null):void
		{
			this._bitmapSkin = bitmap;
			_bitmapSkin.scale9Grid = scale9;
		}
		
		public function clone():UISkin2
		{
			var ds:UISkin2 = new UISkin2();
			ds.fillStyle = this._fillStyle.clone();
			ds.textStyle = this._textStyle.clone();
			return ds;
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
	}
}