/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.fal.ui
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.finalbug.fal.data.Position;
	import org.finalbug.fal.data.Status;
	import org.finalbug.fal.draw.Graph;
	import org.finalbug.fal.events.DataEvent;
	import org.finalbug.fal.uistyle.stylefactory.CheckBoxStyleFactory;
	import org.finalbug.fal.uistyle.styles.FillStyle;
	
	/**
	 * radio button
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */
	public class RadioButton extends UIObject
	{
		protected static var groupList:Object = new Object();
		
		private const BOX_SIZE:Number = 12;
		private const OFFSET:Number = 3;
		private const OUTERBOX_SIZE:Number = 2;
		private const OUTER_INNER_OFFSET:Number = 1;
		
		private var _label:String;
		private var _selected:Boolean = false;
		private var _group:String = "";
		private var _labelPosition:String;
		
		private var outerBox:Sprite;
		private var innerBox:Sprite;
		private var txt:Label;
		private var bg:Shape;
		
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
		public function RadioButton(label:String = "RadioButton", groupName:String = "ungrouped")
		{
			_group = groupName;
			_label = label == "" ? "RadioButton" : label;
			if(RadioButton.groupList[_group] == null)
			{
				RadioButton.groupList[_group] = new Array();
			}
			RadioButton.groupList[_group].push(this);
			//
			outerBox = new Sprite();
			innerBox = new Sprite();
			txt = new Label(_label);
			bg = new Shape();
			//
			Graph.drawLucidRectangle(bg);
			innerBox.visible = false;
			//
			this.addAll(outerBox, innerBox, txt, bg);
			//
			this.registerStatus(Status.NORMAL_STATUS, CheckBoxStyleFactory.createNormalStyle(), true);
			this.registerStatus(Status.MOUSE_OVER_STATUS, CheckBoxStyleFactory.createOverStyle());
			this.registerStatus(Status.MOUSE_DOWN_STATUS, CheckBoxStyleFactory.createDownStyle());
			this.registerStatus(Status.DISABLE_STATUS, CheckBoxStyleFactory.createDisableStyle());
			//
			this.addEventListener(MouseEvent.CLICK, clickBoxHandler);
		}
		
		override protected function updateView():void
		{
			if(currentStyle != null)
			{
				drawOuterBox();
				drawInnerBox();
				txt.textFormat = currentStyle.textStyle.format;
				setPosition();
			}
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
			var ww:Number = Math.max(BOX_SIZE, txt.width);
			var hh:Number = Math.max(BOX_SIZE, txt.height);
			//
			if(_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				innerBox.x = outerBox.x = txt.width + OFFSET + BOX_SIZE / 2;
				innerBox.y = outerBox.y = hh / 2;
				bg.width = BOX_SIZE + OFFSET + txt.width;
				bg.height = hh;
			}
			else if(_labelPosition == Position.TOP)
			{
				innerBox.y = outerBox.y = BOX_SIZE / 2;
				innerBox.x = outerBox.x = ww / 2;
				txt.x = (ww - txt.width) / 2;
				txt.y = BOX_SIZE + OFFSET;
				bg.width = ww;
				bg.height = BOX_SIZE + OFFSET + txt.height;
			}
			else if(_labelPosition == Position.BOTTOM)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				innerBox.x = outerBox.x = ww / 2;
				innerBox.y = txt.height + OFFSET + BOX_SIZE;
				bg.width = ww;
				bg.height = BOX_SIZE + OFFSET + txt.height;
			}
			else
			{
				innerBox.x = outerBox.x = BOX_SIZE / 2;
				innerBox.y = outerBox.y = hh / 2;
				txt.x = BOX_SIZE + OFFSET;
				txt.y = (hh - txt.height) / 2;
				bg.width = BOX_SIZE + OFFSET + txt.width;
				bg.height = hh;
			}
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
				ee.dataName = "selected";
				ee.oldData = !this._selected;
				ee.newData = this._selected;
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
		
		private function drawOuterBox():void
		{
			var fs:FillStyle = currentStyle.fillStyle;
			outerBox.graphics.clear();
			outerBox.graphics.beginFill(fs.bgColor, 1);
			outerBox.graphics.drawCircle(0, 0, BOX_SIZE / 2);
			outerBox.graphics.endFill();
			outerBox.filters = [fs.createGlowFilter()];
		}
		
		private function drawInnerBox():void
		{
			var fs:FillStyle = currentStyle.fillStyle;
			innerBox.graphics.clear();
			innerBox.graphics.beginFill(fs.borderColor, 1);
			innerBox.graphics.drawCircle(0, 0, BOX_SIZE / 2 - OUTERBOX_SIZE - OUTER_INNER_OFFSET);
			innerBox.graphics.endFill();
		}
	}
}