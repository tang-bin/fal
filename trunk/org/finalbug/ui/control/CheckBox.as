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
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.events.DataEvent;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.skin.SkinElement;
	import org.finalbug.ui.skin.UISkinModel;
	import org.finalbug.ui.style.FillStyle;
	import org.finalbug.ui.style.stylefactory.CheckBoxStyleFactory;
	
	/**
	 * CheckBox component.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class CheckBox extends UIObject
	{
		private const OFFSET:Number = 3;
		
		private var _selected:Boolean = false;
		private var _label:String = "CheckBox";	
		private var _labelPosition:String;
		
		private var box:SkinElement;
		private var txt:Label;
		private var back:Shape;
		
		/**
		 * If is checked of not.
		 */
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			if(value != _selected)
			{
				_selected = value;
				this.status = this.enabled ? Status.SELECTED : Status.SELECTED_DISABLE;
			}
		}
		
		/**
		 * Label text beside box.
		 */	
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			_label = value;
			txt.text = value;
			resetPosition();
		}
		
		public function get labelPosition():String
		{
			return _labelPosition;
		}
		public function set labelPosition(value:String):void
		{
			_labelPosition = value;
			resetPosition();
		}
		
		public function set labelColor(value:Number):void
		{
			if(txt != null)
			{
				txt.textColor = value;
			}
		}
		public function get labelColor():Number
		{
			return txt.textColor;
		}
		
		override public function set status(value:String):void
		{
			if(this.selected)
			{
				switch(value)
				{
					case Status.NORMAL: value = Status.SELECTED; break;
					case Status.MOUSE_OVER: value = Status.SELECTED_MOUSE_OVER; break;
					case Status.MOUSE_DOWN: value = Status.SELECTED_MOUSE_DOWN; break;
					case Status.DISABLE: value = Status.SELECTED_DISABLE; break;
				}
			}
			super.status = value;
		}
		
		/**
		 * Create a new CheckBox object.
		 * 
		 * @param label
		 * @param style
		 */		
		public function CheckBox(label:String = "checkBox")
		{
			super();
			createChildren();
		}
		
		override protected function updateView():void
		{
			super.updateView();
			resetPosition();
		}
		
		/**
		 * set elements position.
		 */		
		private function resetPosition():void
		{
			var ww:Number = Math.max(txt.width, box.width);
			var hh:Number = Math.max(txt.height, box.height);
			//
			if(_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				box.x = txt.width + OFFSET;
				box.y = (hh - box.height) / 2;
				back.width = ww + OFFSET + box.width;
				back.height = hh;
			}
			else if(_labelPosition == Position.TOP)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				box.x = (ww - box.width) / 2;
				box.y = txt.height + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + box.height;
			}
			else if(_labelPosition == Position.BOTTOM)
			{
				box.x = (ww - box.width) / 2;
				box.y = 0;
				txt.x = (ww - txt.height) / 2;
				txt.y = box.height + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + box.height;
			}
			else
			{
				box.x = 0;
				box.y = (hh - box.height) / 2;
				txt.x = box.width + OFFSET;
				txt.y = (hh - txt.height) / 2;
				back.width = ww + OFFSET + box.width;
				back.height = hh;
			}
		}
		
		private function createChildren():void
		{
			// outer box
			box = new SkinElement();
			txt = new Label(_label);
			back = new Shape();
			this.addAll(box, txt, back);
			//
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			//
			uiSkinData = UISkinModel.instance.checkBoxSkinData;
			uiSkinData.setSkin(box, txt);
			//
			updateView();
		}
		
		//***************************************
		// HANDLER
		//***************************************
		
		/**
		 * invoked when click checkbox.
		 * 
		 * @param e
		 */		
		private function clickHandler(e:MouseEvent):void
		{
			this.selected = !this.selected;
			this.dispatchEvent(new DataEvent(DataEvent.CHANGE_DATA));
		}
	}
}
