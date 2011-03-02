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
	import org.finalbug.ui.style.UIStyle;
	import org.finalbug.data.Status;
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.widgets.Tooltip;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	/**
	 * UIObject is the super class for all of the UI controls.
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class UIObject extends Bin
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		/**
		 * Tooltip text. Will be shown when mouse roll over.
		 * 
		 * @see org.finalbug.widgets.Tooltip
		 */
		public var tooltip:String = "";

		protected var uiStyle:UIStyle;

		/**
		 * current status string.
		 * 
		 * @see org.finalbug.data.Status
		 */
		protected var currentStatus:String;

		private var _enabled:Boolean = true;

		private var _autoMouseEvent:Boolean = false;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * Call default mouse roll over, mouse down, mouse roll out event if 
		 * auotMouseEvent is true.
		 * 
		 * Call default mouse event will make UIObject reset size(call resetSize() method).
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
		 * @see org.finalbug.data.Status
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
		 * Enable or disable UIObject.
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
					if (obj is UIObject)
					{
						(obj as UIObject)._enabled = this._enabled;
					}
				}
			}
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * Create an new UIObject.
		 * 
		 * @param skinData
		 */
		public function UIObject(uiStyle:UIStyle = null)
		{
			super();
			this.uiStyle = uiStyle;
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Re-check UIObject's size by its children's size.
		 * Width and height value may be reset after pack, but resetSize() method
		 * will not be called.
		 * 
		 * @param xSpace Final width = real width + xSpace
		 * @param ySpace Final height = real height + ySpace
		 */
		public function pack(xSpace:Number = 0, ySpace:Number = 0):void
		{
			trace("run pack", this);
			var maxWidth:Number = 0;
			var maxHeight:Number = 0;
			for (var i:uint = this.numChildren ; --i >= 0 ;)
			{
				var obj:DisplayObject = this.getChildAt(i);
				maxWidth = Math.max(maxWidth, obj.x + obj.width);
				maxHeight = Math.max(maxHeight, obj.y + obj.height);
			}
			_layoutStyle.setValueSilent("width", maxWidth + xSpace);
			_layoutStyle.setValueSilent("height", maxHeight + ySpace);
		}

		/******************* PROTECTED *************************************************/
		/**
		 * Size initialization.
		 * This method will change layout style and resetSize() method may be called
		 * if size is changed.
		 * 
		 * @param width New width, number in pixel or percent string.
		 * @param height New height, number in pixel or percent string.
		 */
		protected function initSize(width:*, height:*):void
		{
			_layoutStyle.setValue("width", width);
			_layoutStyle.setValue("height", height);
			sizeChanged = true;
		}

		/**
		 * This method should be override by the sub classes of UIObject.
		 * changing style such as color, alpha, fillStyle, etc.
		 * 
		 * To change the size and position, please override method updateSize.
		 */
		protected function updateStyle():void
		{
			// show be override by sub classes.
		}

		/******************* PRIVATE ***************************************************/
		/******************* HANDLER ***************************************************/
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
	}
}