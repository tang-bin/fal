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
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import org.finalbug.data.Status;
	import org.finalbug.ui.glazes.Image;
	import org.finalbug.ui.skin.ButtonSkinData;
	import org.finalbug.ui.skin.Skin;
	import org.finalbug.ui.skin.UISkinDataAbstract;
	
	/**
	 * Button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */  
	public class Button extends UIObject
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		override protected function updateSize():void
		{
			super.updateSize();
			if(bg != null)
			{
				bg.width = this.width;
				bg.height = this.height;
			}
			if(_label != null)
			{
				_label.toCenter();
			}
		}
		
		override public function set status(value:String):void
		{
			if(_holdable)
			{
				if(value == Status.NORMAL)
				{
					value = _hold ? Status.HOLD : Status.NORMAL;
				}
				else if(value == Status.MOUSE_DOWN)
				{
					value = _hold ? Status.HOLD_MOUSE_DOWN : Status.MOUSE_DOWN;
				}
				else if(value == Status.MOUSE_OVER)
				{
					value = _hold ? Status.HOLD_MOUSE_OVER : Status.MOUSE_OVER;
				}
			}
			super.status = value;
		}
		
		
		override protected function mouseDownHandler(e:MouseEvent):void
		{
			super.mouseDownHandler(e);
			if(_holdable)
			{
				_hold = !_hold;
			}
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		// lable string
		private var _labelStr:String = "Button";
		
		// children
		private var _label:Label;
		private var bg:Skin;
		private var icon:Image;
		
		// variables
		private var _holdable:Boolean = false;
		private var _hold:Boolean = false;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
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
			if(_labelStr != value)
			{
				_labelStr = value;
				this.updateSize();
			}
		}
		
		public function get holdable():Boolean
		{
			return _holdable;
		}
		
		public function set holdable(value:Boolean):void
		{
			_holdable = value;
			if(!_holdable)
			{
				_hold = false;
			}
		}
		
		public function get hold():Boolean
		{
			return _hold;
		}
		
		public function set hold(value:Boolean):void
		{
			trace("set hole", value, _holdable, this._hold);
			if(_holdable && this._hold != value)
			{
				_hold = value;
				this.status = _hold ? Status.HOLD : Status.NORMAL;
			}
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
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
			if(uiSkinData == null) uiSkinData = new org.finalbug.ui.skin.ButtonSkinData();
			uiSkinData.bindChildren(bg, _label);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}