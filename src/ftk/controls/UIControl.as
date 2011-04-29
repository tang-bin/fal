// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import ftk.events.DataEvent;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	import ftk.data.Status;
	import ftk.display.Bin;
	import ftk.style.UIStyle;
	import ftk.widgets.Tooltip;

	/**
	 * UIControl is the super class for UI controls.
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class UIControl extends Bin
	{
		/**
		 * Create an new UIControl.
		 * 
		 * @param uiStyle
		 */
		public function UIControl(uiStyle:UIStyle = null)
		{
			super();
			this._uiStyle = uiStyle;
			if (_uiStyle != null)
			{
				_uiStyle.addEventListener(DataEvent.CHANGE_STYLE, changeStyleHandler);
			}
		}

		/**
		 * Tooltip text. Will be shown when mouse roll over.
		 * 
		 * @see ftk.widgets.Tooltip
		 */
		public var tooltip:String = "";

		/**
		 * current status string.
		 * 
		 * @see ftk.data.Status
		 */
		protected var currentStatus:String;

		private var _enabled:Boolean = true;

		private var _uiStyle:UIStyle;

		private var _autoMouseEvent:Boolean = false;

		public function get uiStyle():UIStyle
		{
			return _uiStyle;
		}

		public function set uiStyle(value:UIStyle):void
		{
			if (value != _uiStyle)
			{
				if (_uiStyle != null)
				{
					_uiStyle.removeEventListener(DataEvent.CHANGE_STYLE, changeStyleHandler);
				}
				_uiStyle = value;
				_uiStyle.addEventListener(DataEvent.CHANGE_STYLE, changeStyleHandler);
			}
		}

		/**
		 * Call default mouse roll over, mouse down, mouse roll out event if 
		 * auotMouseEvent is true.
		 * 
		 * Call default mouse event will make UIControl reset size(call resetSize() method).
		 * 
		 * @default false
		 */
		public function get autoMouseEvent():Boolean
		{
			return _autoMouseEvent;
		}

		public function set autoMouseEvent(value:Boolean):void
		{
			if (value != _autoMouseEvent)
			{
				_autoMouseEvent = value;
				if (value)
				{
					this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
					this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
					this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				}
				else
				{
					this.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
					this.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
					this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
					this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				}
			}
		}

		/**
		 * status of UI object. Change status will change SkinData's status.
		 * 
		 * @see ftk.data.Status
		 */
		public function get status():String
		{
			return currentStatus;
		}

		public function set status(value:String):void
		{
			if (value != currentStatus && value != "")
			{
				currentStatus = value;
				updateStyle();
				updateSize();
			}
		}

		/**
		 * Enable or disable UIControl.
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(value:Boolean):void
		{
			if (_enabled != value)
			{
				_enabled = value;
				this.mouseEnabled = _enabled;
				this.status = _enabled ? Status.NORMAL : Status.DISABLED;
				//
				for (var i:uint = this.numChildren; --i >= 0; )
				{
					var obj:DisplayObject = this.getChildAt(i) as DisplayObject;
					if (obj is UIControl)
					{
						(obj as UIControl)._enabled = this._enabled;
					}
				}
			}
		}

		/**
		 * This method should be override by the sub classes of UIControl.
		 * changing style such as color, alpha, fillStyle, etc.
		 * 
		 * To change the size and position, please override method updateSize.
		 */
		protected function updateStyle():void
		{
			// show be override by sub classes.
		}

		/**
		 * Auto mouse event roll over handler.
		 * @param e
		 */
		protected function rollOverHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
			if (tooltip != null && tooltip != "")
			{
				Tooltip.show(this, tooltip);
			}
		}

		/**
		 * Auto mouse event roll out handler.
		 * @param e
		 */
		protected function rollOutHandler(e:MouseEvent):void
		{
			Tooltip.remove();
			this.status = Status.NORMAL;
		}

		/**
		 * Auto mouse event down handler.
		 * @param e
		 */
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_DOWN;
		}

		/**
		 * Auto mouse event up handler.
		 * @param e
		 */
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
		}

		protected function changeStyleHandler(e:DataEvent):void
		{
			this.updateStyle();
		}
	}
}