/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.control
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.finalbug.core.data.Status;
	import org.finalbug.core.display.Bin;
	import org.finalbug.core.utils.MathUtil;
	import org.finalbug.framework.app.Tooltip;
	import org.finalbug.ui.style.DisplayStyle;
	
	/**
	 * Class Control is the super class for all of the controls.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class UIObject extends Bin
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		
		public var tooltip:String = "";
		
		protected var statusList:Object = new Object();
		protected var currentStatus:String;
		
		private var _enabled:Boolean = true;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		public function get status():String
		{
			return currentStatus;
		}
		public function set status(value:String):void
		{
			if(value != currentStatus && value != "" && statusList[value] != null)
			{
				currentStatus = value;
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
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("width", MathUtil.getNumArea(value, minWidth, maxWidth));
			}
			this.updateView();
		}
		
		override public function set height(value:Number):void
		{
			for each(var status:DisplayStyle in this.statusList)
			{
				status.layoutStyle.setValue("height", MathUtil.getNumArea(value, minHeight, maxHeight));
			}
			this.updateView();
		}
		
		/****************************************
		 * 
		 * constructor.
		 * 
		 ****************************************/
		public function UIObject()
		{
			super();
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		override protected function updateView():void
		{
			super.updateView();
			if(currentStyle != null && currentStyle.layoutStyle != null)
			{
				this.displayWidth = currentStyle.layoutStyle.width;
				this.displayHeight = currentStyle.layoutStyle.height;
			}
		}
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		public function registerStatus(name:String, style:DisplayStyle, enforce:Boolean = false):void
		{
			style.owner = this;
			statusList[name] = style;
			if(enforce)
			{
				this.status = name;
			}
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
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		protected function get currentStyle():DisplayStyle
		{
			return statusList[this.currentStatus];
		}
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
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
			if(this.statusList[Status.MOUSE_OVER] != null)
			{
				this.status = Status.NORMAL;
				Tooltip.remove();
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