//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.control
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.finalbug.data.Status;
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.skin.UISkinDataAbstract;
	import org.finalbug.ui.widgets.Tooltip;

	/**
	 * UIObject is the super class for all of the UI controls.
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class UIObject extends Bin
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################

		/**
		 * 
		 * @default 
		 */
		public var tooltip:String = "";

		/**
		 * 
		 * @default 
		 */
		protected var uiSkinData:UISkinDataAbstract;
		/**
		 * 
		 * @default 
		 */
		protected var currentStatus:String;
		
		private var _enabled:Boolean=true;

		//#######################################
		// GETTER and SETTER
		//#######################################

		/**
		 * 
		 * @return 
		 */
		public function get status():String
		{
			return currentStatus;
		}

		/**
		 * 
		 * @param value
		 */
		public function set status(value:String):void
		{
			if (value != currentStatus && value != "")
			{
				currentStatus=value;
				if (uiSkinData != null)
				{
					uiSkinData.changeStatus(this.currentStatus);
				}
				updateStyle();
				updateSize();
			}
		}


		/**
		 * 
		 * @return 
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}

		/**
		 * 
		 * @param value
		 */
		public function set enabled(value:Boolean):void
		{
			if (_enabled != value)
			{
				_enabled=value;
				this.mouseEnabled=_enabled;
				this.status=_enabled ? Status.NORMAL : Status.DISABLED;
				//
				for (var i:uint=this.numChildren; --i >= 0; )
				{
					var obj:DisplayObject=this.getChildAt(i) as DisplayObject;
					if (obj is UIObject)
					{
						(obj as UIObject)._enabled=this._enabled;
					}
				}
			}
		}
		
		//#######################################
		// constructor.
		//#######################################
		/**
		 * 
		 * @param skinData
		 */
		public function UIObject(skinData:UISkinDataAbstract = null)
		{
			super();
			uiSkinData = skinData;
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param xSpace
		 * @param ySpace
		 */
		public function pack(xSpace:Number = 0, ySpace:Number = 0):void
		{
			var maxWidth:Number = 0;
			var maxHeight:Number = 0;
			for(var i:uint = this.numChildren ; --i >= 0 ;)
			{
				var obj:DisplayObject = this.getChildAt(i);
				maxWidth = Math.max(maxWidth, obj.x + obj.width);
				maxHeight = Math.max(maxHeight, obj.y + obj.height);
			}
			_layoutStyle.setValueSilent("width", maxWidth + xSpace);
			_layoutStyle.setValueSilent("height", maxHeight + ySpace);
		}
		
		//#######################################
		// PROTECTED
		//#######################################

		/**
		 * 
		 * @param width
		 * @param height
		 */
		protected function initSize(width:*, height:*):void
		{
			_layoutStyle.setValue("width", width);
			_layoutStyle.setValue("height", height);
			sizeChanged = true;
		}
		
		/**
		 * This method need be override by the sub classes of UIObject to realize
		 * changing style such as color, alpha, fillStyle, etc.
		 * 
		 * To change the size and position, please override method updateSize.
		 */
		protected function updateStyle():void
		{
			// show be override by sub classes.
		}
		
		//#######################################
		// PRIVATE
		//#######################################

		//#######################################
		// HANDLER
		//#######################################

		/**
		 * 
		 * @param e
		 */
		protected function rollOverHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
			if (tooltip != null && tooltip != "")
			{
				Tooltip.show(tooltip);
			}
		}

		/**
		 * 
		 * @param e
		 */
		protected function rollOutHandler(e:MouseEvent):void
		{
			Tooltip.remove();
			this.status = Status.NORMAL;
		}

		/**
		 * 
		 * @param e
		 */
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_DOWN;
		}

		/**
		 * 
		 * @param e
		 */
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
		}
	}
}