package fas.ui
{
	import fas.data.Position;
	import fas.events.DataEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	/**
	 * radio button
	 * 
	 * @author Finalbug
	 * @since 0.1
	 */	
	public class RadioButton extends UIObject
	{
		protected static var groupList:Object = new Object();
		
		private var _label:String;
		private var _selected:Boolean = false;
		private var _group:String = "";
		private var _labelPosition:String;
		
		private var outerBox:Sprite;
		private var innerBox:Sprite;
		private var txt:Label;
		private var act:Sprite;
		
		public var outerBoxColor:uint = 0xCCCCCC;
		public var innerBoxColor:uint = 0x990000;
		public var boxSize:Number = 12;
		public var offset:Number = 3;
		public var outerBoxSize:Number = 2;
		public var outerInnerOffset:Number = 1;
		
		/**
		 * label string
		 */		
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			_label = value == "" ? "RadioButton" : value;
			txt.text = value;
			setPosition();
		}
		
		/**
		 * selected or not.
		 */		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(v:Boolean):void
		{
			if(_selected != v)
			{
				_selected = v;
				innerBox.visible = v;
			}
		}
		
		/**
		 * button's group name. only one button can be selected in one group.
		 */		
		public function get groupName():String
		{
			return _group;
		}
		public function set groupName(value:String):void
		{
			if(value != _group && RadioButton.groupList[groupName] != null)
			{
				var oldArray:Array = RadioButton.groupList[_group] as Array;
				for(var i:Number = oldArray.length ; --i >= 0 ; )
				{
					var v:RadioButton = oldArray[i] as RadioButton;
					if(v == this)
					{
						oldArray.splice(i, 1);
						if(RadioButton.groupList[value] == null)
						{
							RadioButton.groupList[value] = new Array;
						}
						RadioButton.groupList[value].push(v);
						break;
					}
				}
			}
		}
		
		/**
		 * create a new RadioButton object
		 * 
		 * @param groupName Group name.
		 * @param label Label field
		 * @param style Display style
		 */		
		public function RadioButton(groupName:String = "ungrouped", label:String = "RadioButton")
		{
			this.uiName = "RadioButton";
			_group = groupName;
			_label = label == "" ? "RadioButton" : label;
			//
			if(RadioButton.groupList[_group] == null)
			{
				RadioButton.groupList[_group] = new Array();
			}
			RadioButton.groupList[_group].push(this);
			//
			outerBox = new Sprite();
			innerBox = new Sprite();
			var tf:TextFormat = new TextFormat("Arial", 12, 0x333333);
			txt = new Label(_label, tf);
			innerBox.visible = false;
			//
			act = new Sprite();
			act.graphics.beginFill(0, 0);
			act.graphics.drawRect(0, 0, 10, 10);
			act.graphics.endFill();
			//
			this.addChild(outerBox);
			this.addChild(innerBox);
			this.addChild(txt);
			this.addChild(act);
			//
			drawOuterBox(outerBox);
			drawInnerBox(innerBox);
			//
			setPosition();
			setEvent();
		}
		
		/**
		 * get selected radiobutton by groupName.
		 * 
		 * @param groupName 
		 * @return If no group or no button is selected, return null.
		 */		
		public static function getSelectedItem(groupName:String):RadioButton
		{
			if(RadioButton.groupList[groupName] != null)
			{
				for each(var v:RadioButton in RadioButton.groupList[groupName])
				{
					if(v.selected)
					{
						return v;
					}
				}
			}
			return null;
		}
		
		private function setPosition():void
		{
			var ww:Number = Math.max(boxSize, txt.width);
			var hh:Number = Math.max(boxSize, txt.height);
			//
			if(_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				innerBox.x = outerBox.x = txt.width + offset + boxSize / 2;
				innerBox.y = outerBox.y = hh / 2;
				act.width = boxSize + offset + txt.width;
				act.height = hh;
			}
			else if(_labelPosition == Position.TOP)
			{
				innerBox.y = outerBox.y = boxSize / 2;
				innerBox.x = outerBox.x = ww / 2;
				txt.x = (ww - txt.width) / 2;
				txt.y = boxSize + offset;
				act.width = ww;
				act.height = boxSize + offset + txt.height;
			}
			else if(_labelPosition == Position.BOTTOM)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				innerBox.x = outerBox.x = ww / 2;
				innerBox.y = txt.height + offset + boxSize;
				act.width = ww;
				act.height = boxSize + offset + txt.height;
			}
			else
			{
				innerBox.x = outerBox.x = boxSize / 2;
				innerBox.y = outerBox.y = hh / 2;
				txt.x = boxSize + offset;
				txt.y = (hh - txt.height) / 2;
				act.width = boxSize + offset + txt.width;
				act.height = hh;
			}
		}
		
		private function setEvent():void
		{
			act.addEventListener(MouseEvent.CLICK, clickBoxHandler);
		}
		
		private function clickBoxHandler(e:MouseEvent):void
		{
			if(!_selected)
			{
				unselectedGroup();
				_selected = true;
				innerBox.visible = true;
				//
				var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
				this.dispatchEvent(ee);
			}
		}
		
		private function unselectedGroup():void
		{
			for each(var v:RadioButton in RadioButton.groupList[_group])
			{
				if(v != null)
				{
					v.selected = false;
				}
			}
		}
		
		private function drawOuterBox(target:Sprite):void
		{
			if(target != null)
			{
				target.graphics.clear();
				target.graphics.beginFill(outerBoxColor, 1);
				target.graphics.drawCircle(0, 0, boxSize / 2);
				target.graphics.endFill();
				//
				target.graphics.beginFill(0xFFFFFF, 1);
				target.graphics.drawCircle(0, 0, boxSize / 2 - outerBoxSize);
				target.graphics.endFill();
			}
		}
		
		private function drawInnerBox(target:Sprite):void
		{
			if(target != null)
			{
				target.graphics.clear();
				target.graphics.beginFill(innerBoxColor, 1);
				target.graphics.drawCircle(0, 0, boxSize / 2 - outerBoxSize - outerInnerOffset);
				target.graphics.endFill();
			}
		}
	}
}