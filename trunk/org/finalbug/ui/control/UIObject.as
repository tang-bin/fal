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
package org.finalbug.ui.control
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.finalbug.data.SetType;
	import org.finalbug.data.Status;
	import org.finalbug.errors.UIError;
	import org.finalbug.ui.Bin;
	import org.finalbug.ui.style.LayoutStyle;
	import org.finalbug.ui.style.UISkin;
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
		//***************************************
		// DEFINE
		//***************************************
		
		public var tooltip:String = "";
		public var autoResizeChildren:Boolean = true;
		
		protected var skinList:Object = new Object();
		protected var currentStatus:String;
		
		private var _enabled:Boolean = true;
		private var _layoutStyle:LayoutStyle;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get status():String
		{
			return currentStatus;
		}
		public function set status(value:String):void
		{
			if(value != currentStatus && value != "" && skinList[value] != null)
			{
				currentStatus = value;
				this.countSizeAndPosition();
				updateView();
			}
		}
		
		public function get layoutStyle():LayoutStyle
		{
			return _layoutStyle;
		}
		public function set layoutStyle(value:LayoutStyle):void
		{
			_layoutStyle = value;
			if(_layoutStyle != null)
			{
				LayoutManager.instance.addLayout(this, _layoutStyle);
			}
			else
			{
				LayoutManager.instance.removeLayout(this);
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		public function set enabled(value:Boolean):void
		{
			if(_enabled != value)
			{
				_enabled = value;
				this.mouseEnabled = _enabled;
				this.status = _enabled ? Status.NORMAL : Status.DISABLE;
				//
				for(var i:uint = this.numChildren ; --i >= 0 ; )
				{
					var obj:DisplayObject = this.getChildAt(i) as DisplayObject;
					if(obj is UIObject)
					{
						(obj as UIObject)._enabled = this._enabled;
					}
				}
			}
		}
		
		override public function set width(value:Number):void
		{
			var widthValue:Number = MathUtil.getNumArea(value, minWidth, maxWidth)
			_layoutStyle.setValue("width", widthValue);
			this.displayWidth = widthValue;
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set height(value:Number):void
		{
			var heightValue:Number = MathUtil.getNumArea(value, minHeight, maxHeight)
			_layoutStyle.setValue("height", heightValue);
			this.displayHeight = heightValue;
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
		
		//***************************************
		// constructor.
		//***************************************
		public function UIObject()
		{
			super();
			_layoutStyle = new LayoutStyle();
			LayoutManager.instance.addLayout(this, _layoutStyle);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		override protected function callAtAdded():void
		{
			countSizeAndPosition();
			updateView();
		}
		
		override protected function countSizeAndPosition():void
		{
			this.displayWidth = _layoutStyle.width;
			this.displayHeight = _layoutStyle.height;
			var newX:Number = _layoutStyle.x;
			var newY:Number = _layoutStyle.y;
			if(!isNaN(newX)) super.x = newX;
			if(!isNaN(newY)) super.y = newY;
		}
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function refresh():void
		{
			this.countSizeAndPosition();
			this.updateView();
			if(this.autoResizeChildren)
			{
				for(var i:uint = this.numChildren ; --i >= 0 ; )
				{
					var child:DisplayObject = this.getChildAt(i);
					if(child is UIObject)
					{
						(child as UIObject).refresh();
					}
				}
			}
		}
		
		public function setSkin(status:String, style:UISkin, asDefualt:Boolean = false):void
		{
			if(style != null)
			{
				style.owner = this;
				skinList[status] = style;
				if(asDefualt)
				{
					this.status = status;
				}
			}
			else
			{
				skinList[status] = null;
				delete skinList[status];
			}
		}
		
		public function getSkin(status:String):UISkin
		{
			if(skinList[status] != null)
			{
				return skinList[status];
			}
			else
			{
				return null;
			}
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		protected function get currentSkin():UISkin
		{
			return skinList[this.currentStatus];
		}
		
		protected function initSize(width:Number, height:Number):void
		{
			this.displayWidth = width;
			this.layoutStyle.setValue("width", width);
			this.displayHeight = height;
			this.layoutStyle.setValue("height", height);
		}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
		
		protected function rollOverHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
			if(tooltip != null && tooltip != "")
			{
				Tooltip.show(tooltip);
			}
		}
		
		protected function rollOutHandler(e:MouseEvent):void
		{
			Tooltip.remove();
			if(this.skinList[Status.MOUSE_OVER] != null)
			{
				this.status = Status.NORMAL;
			}
		}
		
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_DOWN;
		}
		
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER;
		}
	}
}