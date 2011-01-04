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
	import org.finalbug.ui.skin.UISkinDataBase;
	import org.finalbug.ui.style.LayoutStyle;
	import org.finalbug.ui.widgets.Tooltip;
	import org.finalbug.utils.LayoutManager;
	import org.finalbug.utils.MathUtil;

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
		
		override public function set width(value:Number):void
		{
			var widthValue:Number=MathUtil.getNumArea(value, minWidth, maxWidth)
			_layoutStyle.setValue("width", widthValue);
			this.displayWidth=widthValue;
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set height(value:Number):void
		{
			var heightValue:Number=MathUtil.getNumArea(value, minHeight, maxHeight)
			_layoutStyle.setValue("height", heightValue);
			this.displayHeight=heightValue;
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set x(value:Number):void
		{
			_layoutStyle.setValue("left", value);
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set y(value:Number):void
		{
			_layoutStyle.setValue("top", value);
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override protected function callAtAdded():void
		{
			countSizeAndPosition();
			updateView();
		}
		
		override protected function countSizeAndPosition():void
		{
			this.displayWidth=_layoutStyle.width;
			this.displayHeight=_layoutStyle.height;
			var newX:Number=_layoutStyle.x;
			var newY:Number=_layoutStyle.y;
			if (!isNaN(newX))
				super.x=newX;
			if (!isNaN(newY))
				super.y=newY;
		}
		
		//#######################################
		// DEFINE
		//#######################################

		/**
		 * 
		 * @default 
		 */
		public var tooltip:String="";
		/**
		 * 
		 * @default 
		 */
		public var autoResizeChildren:Boolean=true;

		/**
		 * 
		 * @default 
		 */
		protected var uiSkinData:UISkinDataBase;
		/**
		 * 
		 * @default 
		 */
		protected var currentStatus:String;

		private var _enabled:Boolean=true;
		private var _layoutStyle:LayoutStyle;

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
				this.countSizeAndPosition();
				if (uiSkinData != null)
				{
					uiSkinData.setStatus(this.currentStatus);
				}
				updateView();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get layoutStyle():LayoutStyle
		{
			return _layoutStyle;
		}

		/**
		 * 
		 * @param value
		 */
		public function set layoutStyle(value:LayoutStyle):void
		{
			_layoutStyle=value;
			if (_layoutStyle != null)
			{
				LayoutManager.instance.addLayout(this, _layoutStyle);
			}
			else
			{
				LayoutManager.instance.removeLayout(this);
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
				this.status=_enabled ? Status.NORMAL : Status.DISABLE;
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
		public function UIObject(skinData:UISkinDataBase = null)
		{
			super();
			_layoutStyle=new LayoutStyle();
			uiSkinData=skinData;
			LayoutManager.instance.addLayout(this, _layoutStyle);
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
		 */
		public function refresh():void
		{
			this.countSizeAndPosition();
			this.updateView();
			if (this.autoResizeChildren)
			{
				for (var i:uint=this.numChildren; --i >= 0; )
				{
					var child:DisplayObject=this.getChildAt(i);
					if (child is UIObject)
					{
						(child as UIObject).refresh();
					}
				}
			}
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
			this.layoutStyle.setValue("width", width);
			this.layoutStyle.setValue("height", height);
			this.displayWidth=this.layoutStyle.width;
			this.displayHeight=this.layoutStyle.height;
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
			this.status=Status.MOUSE_OVER;
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
			this.status=Status.NORMAL;
		}

		/**
		 * 
		 * @param e
		 */
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.status=Status.MOUSE_DOWN;
		}

		/**
		 * 
		 * @param e
		 */
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.status=Status.MOUSE_OVER;
		}
	}
}