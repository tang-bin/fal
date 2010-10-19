/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.ui.control
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.finalbug.data.Position;
	import org.finalbug.data.Status;
	import org.finalbug.events.DataEvent;
	import org.finalbug.ui.glazes.Flat;
	import org.finalbug.ui.style.stylefactory.CheckBoxStyleFactory;
	import org.finalbug.ui.style.FillStyle;
	
	/**
	 * CheckBox component.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */
	public class CheckBox extends UIObject
	{
		private const BOX_SIZE:Number = 12;
		private const THICKNESS:Number = 2;
		private const OFFSET:Number = 3;
		
		private var _selected:Boolean = false;
		private var _label:String = "CheckBox";	
		private var _labelPosition:String;
		
		private var innerBox:Sprite;
		private var outerBox:Flat
		private var txt:Label;
		private var back:Shape;
		
		/**
		 * if is checked of not.
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
				innerBox.visible = value;
			}
		}
		
		/**
		 * label text beside box.
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
			drawOuterBox();
			drawInnerBox();
			txt.textFormat = currentStyle.textStyle.format;
			innerBox.visible = _selected;
			resetPosition();
		}
		
		/**
		 * set elements position.
		 */		
		private function resetPosition():void
		{
			var ww:Number = Math.max(txt.width, BOX_SIZE);
			var hh:Number = Math.max(txt.height, BOX_SIZE);
			//
			if(_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				outerBox.x = txt.width + OFFSET;
				outerBox.y = (hh - outerBox.height) / 2;
				back.width = ww + OFFSET + outerBox.width;
				back.height = hh;
			}
			else if(_labelPosition == Position.TOP)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				outerBox.x = (ww - outerBox.width) / 2;
				outerBox.y = txt.height + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + outerBox.height;
			}
			else if(_labelPosition == Position.BOTTOM)
			{
				outerBox.x = (ww - outerBox.width) / 2;
				outerBox.y = 0;
				txt.x = (ww - txt.height) / 2;
				txt.y = outerBox.height + OFFSET;
				back.width = ww;
				back.height = hh + OFFSET + outerBox.height;
			}
			else
			{
				outerBox.x = 0;
				outerBox.y = (hh - outerBox.height) / 2;
				txt.x = outerBox.width + OFFSET;
				txt.y = (hh - txt.height) / 2;
				back.width = ww + OFFSET + outerBox.width;
				back.height = hh;
			}
			innerBox.x = outerBox.x;
			innerBox.y = outerBox.y;
		}
		
		private function createChildren():void
		{
			// outer box
			outerBox = new Flat();
			innerBox = new Sprite();
			txt = new Label(_label);
			back = new Shape();
			this.addAll(outerBox, innerBox, txt, back);
			//
			this.registerStatus(Status.NORMAL, CheckBoxStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.MOUSE_OVER, CheckBoxStyleFactory.createOverStyle());
			this.registerStatus(Status.MOUSE_DOWN, CheckBoxStyleFactory.createDownStyle());
			this.registerStatus(Status.DISABLE, CheckBoxStyleFactory.createDisableStyle());
			//
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		// event handler
		
		/**
		 * invoked when click checkbox.
		 * 
		 * @param e
		 */		
		private function clickHandler(e:MouseEvent):void
		{
			_selected = !_selected;
			innerBox.visible = _selected;
			this.dispatchEvent(new DataEvent(DataEvent.CHANGE_DATA));
		}
		
		/**
		 * create and draw outer box.
		 * @return 
		 */	
		private function drawOuterBox():void
		{
			outerBox.fillStyle = currentStyle.fillStyle;
		}
		
		/**
		 * create and draw inner box.
		 * @return 
		 */	
		private function drawInnerBox():void
		{
			var fs:FillStyle = currentStyle.fillStyle;
			//
			innerBox.graphics.clear();
			innerBox.graphics.lineStyle(3, fs.borderColor, 1);
			innerBox.graphics.moveTo(THICKNESS, BOX_SIZE / 2);
			innerBox.graphics.lineTo(BOX_SIZE / 2, BOX_SIZE - THICKNESS - 2);
			innerBox.graphics.lineTo(BOX_SIZE, 0);
		}
	}
}
