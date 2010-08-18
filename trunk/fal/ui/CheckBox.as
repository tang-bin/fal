package fas.ui
{
	import fas.data.Position;
	import fas.data.Status;
	import fas.events.DataEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	/**
	 * CheckBox component.
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class CheckBox extends UIObject
	{
		private var _selected:Boolean = false;
		private var _label:String = "CheckBox";	
		private var _labelPosition:String;
		
		private var innerBox:Sprite;
		private var outerBox:Sprite;
		private var txt:Label;
		private var back:Sprite;
		
		private var boxSize:Number = 12;
		private var offset:Number = 3;
		private var outerBoxSize:Number = 2;
		private var outerBoxColor:uint = 0x333333;
		private var innerBoxColor:uint = 0x990000;;
		
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
				changeChecked();
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
			setPosition();
		}
		
		public function get labelPosition():String
		{
			return _labelPosition;
		}
		public function set labelPosition(value:String):void
		{
			_labelPosition = value;
			setPosition();
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
			this.uiName = "CheckBox";
			_label = label;
			//
			createChildren();
			setEvent();
			changeChecked();
		}
		
		/**
		 * Create elements.
		 */		
		private function createChildren():void
		{
			// outer box
			outerBox = createOuterBox();
			this.addChild(outerBox);
			// inner box
			innerBox = createInnerBox();
			this.addChild(innerBox);
			// label
			var tf:TextFormat = new TextFormat("Arial", 12, 0x333333);
			txt = new Label(_label, tf);
			this.addChild(txt);
			// action background, dont display.
			back = new Sprite();
			back.graphics.beginFill(0, 0);
			back.graphics.drawRect(0, 0, 10, 10);
			back.graphics.endFill();
			this.addChild(back);
			//
			setPosition();
		}
		
		/**
		 * Change checked view.
		 */		
		private function changeChecked():void
		{
			innerBox.visible = _selected;
		}
		
		/**
		 * set event listener.
		 */		
		private function setEvent():void
		{
			back.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * set elements position.
		 */		
		private function setPosition():void
		{
			if(outerBox != null && innerBox != null && txt != null && back != null)
			{
				var ww:Number = Math.max(txt.width, boxSize);
				var hh:Number = Math.max(txt.height, boxSize);
				//
				if(_labelPosition == Position.LEFT)
				{
					txt.x = 0;
					txt.y = (hh - txt.height) / 2;
					outerBox.x = txt.width + offset;
					outerBox.y = (hh - outerBox.height) / 2;
					back.width = ww + offset + outerBox.width;
					back.height = hh;
				}
				else if(_labelPosition == Position.TOP)
				{
					txt.x = (ww - txt.width) / 2;
					txt.y = 0;
					outerBox.x = (ww - outerBox.width) / 2;
					outerBox.y = txt.height + offset;
					back.width = ww;
					back.height = hh + offset + outerBox.height;
				}
				else if(_labelPosition == Position.BOTTOM)
				{
					outerBox.x = (ww - outerBox.width) / 2;
					outerBox.y = 0;
					txt.x = (ww - txt.height) / 2;
					txt.y = outerBox.height + offset;
					back.width = ww;
					back.height = hh + offset + outerBox.height;
				}
				else
				{
					outerBox.x = 0;
					outerBox.y = (hh - outerBox.height) / 2;
					txt.x = outerBox.width + offset;
					txt.y = (hh - txt.height) / 2;
					back.width = ww + offset + outerBox.width;
					back.height = hh;
				}
				innerBox.x = outerBox.x;
				innerBox.y = outerBox.y;
			}
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
			changeChecked();
			this.dispatchEvent(new DataEvent(DataEvent.CHANGE_DATA));
		}
		
		/**
		 * create and draw outer box.
		 * @return 
		 */	
		private function createOuterBox():Sprite
		{
			var sp:Sprite = new Sprite();
			//
			sp.graphics.beginFill(0xFFFFFF, 1);
			sp.graphics.drawRect(0, 0, boxSize, boxSize);
			sp.graphics.endFill();
			//
			sp.graphics.beginFill(outerBoxColor, 1);
			sp.graphics.moveTo(0, 0);
			sp.graphics.lineTo(boxSize, 0);
			sp.graphics.lineTo(boxSize, boxSize);
			sp.graphics.lineTo(0, boxSize);
			sp.graphics.lineTo(0, outerBoxSize);
			sp.graphics.lineTo(outerBoxSize, outerBoxSize);
			sp.graphics.lineTo(outerBoxSize, boxSize - outerBoxSize);
			sp.graphics.lineTo(boxSize - outerBoxSize, boxSize - outerBoxSize);
			sp.graphics.lineTo(boxSize - outerBoxSize, outerBoxSize);
			sp.graphics.lineTo(0, outerBoxSize);
			sp.graphics.lineTo(0, 0);
			sp.graphics.endFill();
			//
			return sp;
		}
		
		/**
		 * create and draw inner box.
		 * @return 
		 */	
		private function createInnerBox():Sprite
		{
			var sp:Sprite = new Sprite();
			//
			sp.graphics.lineStyle(3, innerBoxColor, 1);
			sp.graphics.moveTo(outerBoxSize, boxSize / 2);
			sp.graphics.lineTo(boxSize / 2, boxSize - outerBoxSize - 2);
			sp.graphics.lineTo(boxSize, 0);
			//
			return sp;
		}
	}
}
