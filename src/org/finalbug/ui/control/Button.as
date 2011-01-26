// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.ui.control
{
	import org.finalbug.data.Status;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.skin.ButtonSkinData;
	import org.finalbug.ui.skin.Skin;
	import org.finalbug.ui.skin.UISkinDataAbstract;

	import flash.events.MouseEvent;

	/**
	 * Button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class Button extends UIObject
	{

		// ******************* OVERRIDE *****************************
		/**
		 * 
		 */
		override protected function updateSize():void
		{
			super.updateSize();
			//
			if (_autoWidth)
			{
				var newWidth:Number = _label.width + AUTO_SPACE;
				if (newWidth != this.width)
				{
					this.width = newWidth;
					return;
				}
			}
			if (_autoHeight)
			{
				var newHeight:Number = _label.height + AUTO_SPACE;
				if (newHeight != this.height)
				{
					this.height = newHeight;
					return;
				}
			}
			//
			if (_label != null)
			{
				_label.toCenter();
			}
			if (bg != null)
			{
				bg.width = this.width;
				bg.height = this.height;
			}
		}

		/**
		 * 
		 * @param value
		 */
		override public function set status(value:String):void
		{
			if (_holdable)
			{
				if (value == Status.NORMAL)
				{
					value = _hold ? Status.HOLD : Status.NORMAL;
				}
				else if (value == Status.MOUSE_DOWN)
				{
					value = _hold ? Status.HOLD_MOUSE_DOWN : Status.MOUSE_DOWN;
				}
				else if (value == Status.MOUSE_OVER)
				{
					value = _hold ? Status.HOLD_MOUSE_OVER : Status.MOUSE_OVER;
				}
			}
			super.status = value;
		}

		/**
		 * 
		 * @param e
		 */
		override protected function mouseDownHandler(e:MouseEvent):void
		{
			super.mouseDownHandler(e);
			if (_holdable)
			{
				_hold = !_hold;
			}
		}

		// ******************* DEFINE *******************************
		private const AUTO_SPACE:Number = 12;

		// lable string
		private var _labelStr:String = "Button";

		// children
		private var _label:Label;

		private var bg:Skin;

		private var icon:Image;

		// variables
		private var _holdable:Boolean = false;

		private var _hold:Boolean = false;

		private var _autoWidth:Boolean = false;

		private var _autoHeight:Boolean = false;

		// ******************* GETTER and SETTER ********************
		/**
		 * 
		 * @return 
		 */
		public function get autoWidth():Boolean
		{
			return _autoWidth;
		}

		/**
		 * 
		 * @param value
		 */
		public function set autoWidth(value:Boolean):void
		{
			if (_autoWidth != value)
			{
				_autoWidth = value;
				if (value)
				{
					var newWidth:Number = _label.width + AUTO_SPACE;
					if (newWidth != this.width)
					{
						this.width = newWidth;
					}
				}
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get autoHeight():Boolean
		{
			return _autoHeight;
		}

		/**
		 * 
		 * @param value
		 */
		public function set autoHeight(value:Boolean):void
		{
			if (_autoHeight != value)
			{
				_autoHeight = value;
				if (value)
				{
					var newHeight:Number = _label.height + AUTO_SPACE;
					if (newHeight != this.height)
					{
						this.height = newHeight;
					}
				}
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get label():String
		{
			return _labelStr;
		}

		/**
		 * 
		 * @param value
		 */
		public function set label(value:String):void
		{
			if (_labelStr != value)
			{
				_labelStr = value;
				_label.text = value;
				_label.toCenter();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get holdable():Boolean
		{
			return _holdable;
		}

		/**
		 * 
		 * @param value
		 */
		public function set holdable(value:Boolean):void
		{
			_holdable = value;
			if (!_holdable)
			{
				_hold = false;
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get hold():Boolean
		{
			return _hold;
		}

		/**
		 * 
		 * @param value
		 */
		public function set hold(value:Boolean):void
		{
			if (_holdable && this._hold != value)
			{
				_hold = value;
				this.status = _hold ? Status.HOLD : Status.NORMAL;
			}
		}

		// ******************* CONSTRUCTOR **************************.
		/**
		 * 
		 * @param text
		 * @param skin
		 */
		public function Button(text:String = "Button", skin:UISkinDataAbstract = null)
		{
			super(skin);
			// save and init paramters.
			this.mouseChildren = false;
			this._labelStr = text;
			this.initSize(80, 24);
			//
			// create elements
			bg = new Skin();
			_label = new Label(this._labelStr);
			icon = new Image();
			this.addAll(bg, _label, icon);
			//
			// set skin data.
			if (uiSkinData == null) uiSkinData = new ButtonSkinData();
			uiSkinData.bindChildren(bg, _label);
		}
		// ******************* PUBLIC *******************************
		
		
		
		// ******************* PROTECTED ****************************
		
		
		
		// ******************* PRIVATE ******************************
		
		
		
		// ******************* HANDLER ******************************
	}
}