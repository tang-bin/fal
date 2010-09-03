/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package fal.display
{
	import fal.data.Status;
	import fal.style.CSSFilter;
	import fal.style.DisplayStyle;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * Class Control is the super class for all of the controls.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class Control extends Bin
	{
		/****************************************
		 * 
		 * DEFINE
		 * 
		 ****************************************/
		
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
				this.status = _enabled ? Status.NORMAL_STATUS : Status.DISABLE_STATUS;
				//
				for(var i:uint = this.numChildren ; --i >= 0 ; )
				{
					var obj:DisplayObject = this.getChildAt(i) as DisplayObject;
					if(obj is Control)
					{
						(obj as Control)._enabled = this._enabled;
					}
				}
			}
		}
		
		/****************************************
		 * 
		 * fal.display.Controller constructor.
		 * 
		 ****************************************/
		public function Control()
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
		
		public function addCSSFilter(filter:CSSFilter, status:String = ""):void
		{
			for(var dsName:String in statusList)
			{
				if(status == "" || status == dsName)
				{
					var ds:DisplayStyle = statusList[dsName] as DisplayStyle;
					if(ds != null)
					{
						ds.addCSSFilter(filter);
					}
				}
			}
		}
		
		public function removeFilter(filter:CSSFilter, status:String = ""):void
		{
			for(var dsName:String in statusList)
			{
				if(status == "" || status == dsName)
				{
					var ds:DisplayStyle = statusList[dsName] as DisplayStyle;
					if(ds != null)
					{
						ds.removeCSSFilter(filter);
					}
				}
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
			this.status = Status.MOUSE_OVER_STATUS;
		}
		
		protected function rollOutHandler(e:MouseEvent):void
		{
			if(this.statusList[Status.MOUSE_OVER_STATUS] != null)
			{
				this.status = Status.NORMAL_STATUS;
			}
		}
		
		protected function mouseDownHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_DOWN_STATUS;
		}
		
		protected function mouseUpHandler(e:MouseEvent):void
		{
			this.status = Status.MOUSE_OVER_STATUS;
		}
	}
}