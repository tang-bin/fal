// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.controls
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import ftk.data.Position;
	import ftk.data.Status;
	import ftk.events.DataEvent;
	import ftk.graphs.Flat;
	import ftk.style.RadioButtonStyle;
	import ftk.style.UIStyle;
	import ftk.utils.DrawUtil;



	/**
	 * radio button
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class RadioButton extends UIControl
	{

		/**
		 * create a new RadioButton object
		 * 
		 * @param groupName Group name.
		 * @param label Label field
		 * @param style Display style
		 */
		public function RadioButton(label:String = "RadioButton", groupName:String = "ungrouped", style:RadioButtonStyle = null)
		{
			super(style == null ? UIStyle.defaultRadioButtonStyle : style);
			//
			// save data.
			_group = groupName;
			_label = label == "" ? "RadioButton" : label;
			if (RadioButton.groupList[_group] == null)
			{
				RadioButton.groupList[_group] = new Array();
			}
			(RadioButton.groupList[_group] as Array).push(this);
			//
			// create children.
			box = new Flat();
			box.resize(BOX_SIZE, BOX_SIZE);
			flag = new Flat();
			flag.resize(FLAG_SIZE, FLAG_SIZE);
			flag.fillStyle = (uiStyle as RadioButtonStyle).flatFillStyle;
			//
			txt = new Label(_label);
			//
			bg = new Shape();
			DrawUtil.drawBlock(bg.graphics);
			//
			this.addAll(bg, box, flag, txt);
			//
			// set event
			this.addEventListener(MouseEvent.CLICK, clickBoxHandler);
			//
			// set skin data.
			this.status = Status.NORMAL;
		}

		/******************* OVERRIDE **************************************************/
		override public function set status(value:String):void
		{
			if (this.selected)
			{
				value = this.enabled ? Status.SELECTED : Status.SELECTED_DISABLED;
			}
			else
			{
				value = this.enabled ? Status.NORMAL : Status.DISABLED;
			}
			if (this.status != value) super.status = value;
		}

		override protected function updatePosition():void
		{
			var ww:Number = Math.max(BOX_SIZE, txt.width);
			var hh:Number = Math.max(BOX_SIZE, txt.height);
			//
			if (_labelPosition == Position.LEFT)
			{
				txt.x = 0;
				txt.y = (hh - txt.height) / 2;
				box.x = txt.width + OFFSET;
				box.y = (hh - BOX_SIZE) / 2;
				bg.width = BOX_SIZE + OFFSET + txt.width;
				bg.height = hh;
			}
			else if (_labelPosition == Position.BOTTOM)
			{
				box.y = 0;
				box.x = (ww - BOX_SIZE) / 2;
				txt.x = (ww - txt.width) / 2;
				txt.y = BOX_SIZE + OFFSET;
				bg.width = ww;
				bg.height = BOX_SIZE + OFFSET + txt.height;
			}
			else if (_labelPosition == Position.TOP)
			{
				txt.x = (ww - txt.width) / 2;
				txt.y = 0;
				box.x = (ww - BOX_SIZE) / 2;
				box.y = txt.height + OFFSET;
				bg.width = ww;
				bg.height = BOX_SIZE + OFFSET + txt.height;
			}
			else
			{
				box.x = 0;
				box.y = (hh - BOX_SIZE) / 2;
				txt.x = BOX_SIZE + OFFSET;
				txt.y = (hh - txt.height) / 2;
				bg.width = BOX_SIZE + OFFSET + txt.width;
				bg.height = hh;
			}
			var flagOffset:Number = (BOX_SIZE - FLAG_SIZE) / 2;
			flag.x = box.x + flagOffset;
			flag.y = box.y + flagOffset;
		}

		override protected function updateStyle():void
		{
			if (this.currentStatus == Status.SELECTED)
			{
				box.fillStyle = uiStyle.selectedFillStyle;
				txt.textFormat = uiStyle.selectedTextFormat;
				flag.visible = true;
			}
			else
			{
				box.fillStyle = uiStyle.normalFillStyle;
				txt.textFormat = uiStyle.normalTextFormat;
				flag.visible = false;
			}
		}

		/******************* DEFINE ****************************************************/
		/**
		 * 
		 * @default 
		 */
		protected static var groupList:Object = new Object();

		private const BOX_SIZE:Number = 14;

		private const FLAG_SIZE:Number = 7;

		private const OFFSET:Number = 3;

		private var _label:String;

		private var _selected:Boolean = false;

		private var _group:String = "";

		private var _labelPosition:String;

		private var box:Flat;

		private var flag:Flat;

		private var txt:Label;

		private var bg:Shape;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * label string
		 */
		public function get label():String
		{
			return _label;
		}

		/**
		 * 
		 * @param value
		 */
		public function set label(value:String):void
		{
			_label = value == "" ? "RadioButton" : value;
			txt.text = value;
			updatePosition();
		}

		/**
		 * selected or not.
		 */
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * 
		 * @param value
		 */
		public function set selected(value:Boolean):void
		{
			if (_selected != value)
			{
				_selected = value;
				// set any value to update status.
				// real status will be check in set status method.
				this.status = "";
			}
		}

		/**
		 * button's group name. only one button can be selected in one group.
		 */
		public function get groupName():String
		{
			return _group;
		}

		/**
		 * 
		 * @param value
		 */
		public function set groupName(value:String):void
		{
			if (value != _group && RadioButton.groupList[groupName] != null)
			{
				var oldArray:Array = RadioButton.groupList[_group] as Array;
				for (var i:Number = oldArray.length ; --i >= 0 ; )
				{
					var v:RadioButton = oldArray[i] as RadioButton;
					if (v == this)
					{
						oldArray.splice(i, 1);
						if (RadioButton.groupList[value] == null)
						{
							RadioButton.groupList[value] = new Array;
						}
						(RadioButton.groupList[value] as Array).push(v);
						break;
					}
				}
			}
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * get selected radiobutton by groupName.
		 * 
		 * @param groupName 
		 * @return If no group or no button is selected, return null.
		 */
		public static function getSelectedItem(groupName:String):RadioButton
		{
			if (RadioButton.groupList[groupName] != null)
			{
				for each (var v:RadioButton in RadioButton.groupList[groupName])
				{
					if (v.selected)
					{
						return v;
					}
				}
			}
			return null;
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function unselectedGroup():void
		{
			for each (var btn:RadioButton in RadioButton.groupList[_group])
			{
				if (btn != null)
				{
					btn.selected = false;
				}
			}
		}

		/******************* PRIVATE ***************************************************/
		private function clickBoxHandler(e:MouseEvent):void
		{
			if (!_selected)
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
	}
}