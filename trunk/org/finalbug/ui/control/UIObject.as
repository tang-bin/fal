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
	import org.finalbug.ui.style.DisplayStyle;
	import org.finalbug.ui.style.LayoutStyle;
	import org.finalbug.ui.widgets.Tooltip;
	import org.finalbug.utils.DataUtil;
	import org.finalbug.utils.MathUtil;
	
	/**
	 * Class Control is the super class for all of the controls.
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
		
		protected var statusList:Object = new Object();
		protected var currentStatus:String;
		
		private var _enabled:Boolean = true;
		private var _layoutStyle:LayoutStyle;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get statusName():String
		{
			return currentStatus;
		}
		public function set statusName(value:String):void
		{
			if(value != currentStatus && value != "" && statusList[value] != null)
			{
				currentStatus = value;
				this.countSizeAndPosition();
				updateView();
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
				this.statusName = _enabled ? Status.NORMAL : Status.DISABLE;
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
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("width", widthValue);
			}
			if(_layoutStyle != null) _layoutStyle.setValue("width", widthValue);
			this.displayWidth = widthValue;
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set height(value:Number):void
		{
			var heightValue:Number = MathUtil.getNumArea(value, minHeight, maxHeight)
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("height", heightValue);
			}
			if(_layoutStyle != null) _layoutStyle.setValue("height", heightValue);
			this.displayHeight = heightValue;
			this.countSizeAndPosition();
			this.updateView();
		}
		
		override public function set x(value:Number):void
		{
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("left", value);
			}
			if(_layoutStyle != null) _layoutStyle.setValue("left", value);
			if(this.getLayout() == null)
			{
				super.x = value;
			}
			else
			{
				this.countSizeAndPosition();
				this.updateView();
			}
		}
		
		override public function set y(value:Number):void
		{
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("top", value);
			}
			if(_layoutStyle != null) _layoutStyle.setValue("top", value);
			if(this.getLayout() == null)
			{
				super.y = value;
			}
			else
			{
				this.countSizeAndPosition();
				this.updateView();
			}
		}
		
		//***************************************
		// constructor.
		//***************************************
		public function UIObject()
		{
			super();
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
			if(this.getLayout() != null)
			{
				this.displayWidth = this.getLayout().width;
				this.displayHeight = this.getLayout().height;
				var newX:Number = this.getLayout().x;
				var newY:Number = this.getLayout().y;
				if(!isNaN(newX)) super.x = newX;
				if(!isNaN(newY)) super.y = newY;
			}
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
		
		public function setLayoutValue(name:String, value:*, allStatus:Boolean = true, update:Boolean = true):void
		{
			if(_layoutStyle != null)
			{
				_layoutStyle.setValue(name, value);
			}
			if(allStatus)
			{
				for each(var style:DisplayStyle in this.statusList)
				{
					style.layoutStyle.setValue(name, value);
				}
			}
			else
			{
				if(this.currentStyle != null && this.currentStyle.layoutStyle != null)
				{
					this.currentStyle.layoutStyle.setValue(name, value);
				}
			}
			if(update) this.updateView();
		}
		
		public function registerStatus(name:String, style:DisplayStyle, enforce:Boolean = false):void
		{
			style.owner = this;
			statusList[name] = style;
			if(enforce)
			{
				this.statusName = name;
			}
		}
		
		public function setSkin(type:String):void
		{
			
		}
		
		/**
		 * unregister a status of controller.
		 * if defaultName is not empty or null, change the default status.
		 * if defaultName is empty or null, and the unregistering status is the default one
		 * select any one status as the default.
		 * 
		 * @param name
		 */		
		public function unregisterStatus(name:String):void
		{
			if(statusList[name] != null)
			{
				delete statusList[name];
				statusList[name] = null;
			}
		}
		
		public function getStatus(name:String):DisplayStyle
		{
			if(statusList[name] != null)
			{
				return statusList[name];
			}
			else
			{
				return null;
			}
		}
		
		public function getAllStatus():Object
		{
			return statusList;
		}
		
		public function setLayout(style:LayoutStyle, type:String = "global"):void
		{
			style.owner = this;
			if(type == SetType.GLOBAL)
			{
				this._layoutStyle = style;
				this.updateView();
			}
			else if(type == SetType.CURRENT)
			{
				if(currentStyle != null)
				{
					this.currentStyle.layoutStyle = style;
					this.updateView();
				}
			}
			else if(type == SetType.ALL)
			{
				for each(var status:DisplayStyle in this.statusList)
				{
					status.layoutStyle = style;
				}
				this.updateView();
			}
			else
			{
				throw new UIError(UIError.WRONG_TYPE);
			}
		}
		
		public function getLayout():LayoutStyle
		{
			if(_layoutStyle != null)
			{
				return _layoutStyle;
			}
			else if(currentStyle != null && this.currentStyle.layoutStyle != null)
			{
				return currentStyle.layoutStyle;
			}
			else
			{
				return null;
			}
		}
		
		//***************************************
		// PROTECTED
		//***************************************
		
		protected function get currentStyle():DisplayStyle
		{
			return statusList[this.currentStatus];
		}
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
		
		protected function rollOverHandler(e:MouseEvent):void
		{
			this.statusName = Status.MOUSE_OVER;
			if(tooltip != null && tooltip != "")
			{
				Tooltip.show(tooltip);
			}
		}
		
		protected function rollOutHandler(e:MouseEvent):void
		{
			Tooltip.remove();
			if(this.statusList[Status.MOUSE_OVER] != null)
			{
				this.statusName = Status.NORMAL;
			}
		}
		
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.statusName = Status.MOUSE_DOWN;
		}
		
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.statusName = Status.MOUSE_OVER;
		}
	}
}