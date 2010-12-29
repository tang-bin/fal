/******************************************************
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
	import org.finalbug.ui.control.Label;
	import org.finalbug.ui.control.UIObject;
	import org.finalbug.ui.skin.SkinElement;
	import org.finalbug.ui.skin.UISkinModel;
	import org.finalbug.ui.style.FillStyle;
	import org.finalbug.ui.style.stylefactory.CheckBoxStyleFactory;
	import org.finalbug.utils.DrawUtil;
	
	/**
	 * radio button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class RadioButton extends UIObject
	{
		protected static var groupList:Object = new Object();
		
		private const OFFSET:Number = 3;
		
		private var _label:String;
		private var _selected:Boolean = false;
		private var _group:String = "";
		private var _labelPosition:String;
		
		private var box:SkinElement;
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
				this.status = this.enabled ? Status.SELECTED : Status.SELECTED_DISABLE;
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
			createChildren();
		}
		
		override protected function updateView():void
		{
			super.updateView();
			setPosition();
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
		
		private function createChildren():void
		{
			box = new SkinElement();
			txt = new Label(_label);
			bg = new Shape();
			//
			DrawUtil.drawBlock(bg.graphics);
			//
			this.addAll(box, txt, bg);
			//
			this.addEventListener(MouseEvent.CLICK, clickBoxHandler);
			//
			uiSkinData = UISkinModel.instance.radioSkinData;
			uiSkinData.setSkin(box, txt);
		}
		
		private function setPosition():void
		{
			var ww:Number = Math.max(box.width, txt.width);
			var hh:Number = Math.max(box.height, txt.height);
			//
			if(_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				box.x = txt.width + OFFSET + box.width / 2;
				box.y = hh / 2;
				bg.width = box.width + OFFSET + txt.width;
				bg.height = hh;
			}
			else if(_labelPosition == Position.TOP)
			{
				box.y = box.height / 2;
				box.x = ww / 2;
				txt.x = (ww - txt.width) / 2;
				txt.y = box.height + OFFSET;
				bg.width = ww;
				bg.height = box.height + OFFSET + txt.height;
			}
			else if(_labelPosition == Position.BOTTOM)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				box.x = ww / 2;
				txt.height + OFFSET + box.height;
				bg.width = ww;
				bg.height = box.height + OFFSET + txt.height;
			}
			else
			{
				box.x = box.width / 2;
				box.y = hh / 2;
				txt.x = box.width + OFFSET;
				txt.y = (hh - txt.height) / 2;
				bg.width = box.width + OFFSET + txt.width;
				bg.height = hh;
			}
		}
		
		private function clickBoxHandler(e:MouseEvent):void
		{
			if(!_selected)
			{
				unselectedGroup();
				this.selected = true;
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
	}
}