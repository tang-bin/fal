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
package ftk.navigate
{
	import ftk.style.ButtonStyle;
	import ftk.controls.Button;
	import ftk.events.UIEvent;
	import ftk.layout.Container;
	import ftk.utils.StringUtil;

	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	[Event(name="change", type="ftk.events.UIEvent")]
	/**
	 * @author Tang Bin
	 * @since 2011.04
	 */
	public class NavigateBar extends Container
	{
		public function NavigateBar()
		{
			super();
			btns = new Dictionary();
			this.horizontalRank(BUTTON_SPACE, true, false);
			this.autoRank = true;
		}

		protected const BUTTON_SPACE:Number = 0;

		private var tabIDCount:int = 0;

		private var tabCount:int = 0;

		private var btns:Dictionary;

		private var currentSelectedBtn:Button;

		public function get numberTabs():int
		{
			return tabCount;
		}

		public function get selectedID():int
		{
			if (currentSelectedBtn != null)
			{
				return getIDByBtn(currentSelectedBtn);
			}
			else
			{
				return -1;
			}
		}

		public function set selectedID(value:int):void
		{
			var newSelectedBtn:Button = btns[value] as Button;
			if (newSelectedBtn != null && newSelectedBtn != currentSelectedBtn)
			{
				selectBtn(newSelectedBtn, false);
			}
		}

		public function get selectedIndex():int
		{
			if (currentSelectedBtn != null)
			{
				return this.getChildIndex(currentSelectedBtn);
			}
			else
			{
				return -1;
			}
		}

		public function set selectedIndex(value:int):void
		{
			var newSelectedBtn:Button = this.getChildAt(value) as Button;
			if (newSelectedBtn != null && newSelectedBtn != currentSelectedBtn)
			{
				selectBtn(newSelectedBtn, false);
			}
		}

		public function addTab(label:String = "tab"):int
		{
			var newBtn:Button = createTab(label);
			this.addChild(newBtn);
			updateBtnStyle();
			return tabIDCount;
		}

		public function addTabAt(index:int, label:String = "tab"):int
		{
			var newBtn:Button = createTab(label);
			this.addChildAt(newBtn, index);
			updateBtnStyle();
			return tabIDCount;
		}

		public function removeTabByID(tabID:int):void
		{
			var removeBtn:Button = btns[tabID] as Button;
			removeTab(removeBtn);
			updateBtnStyle();
		}

		public function removeTabAt(index:int):void
		{
			var removeBtn:Button = this.getChildAt(index) as Button;
			removeTab(removeBtn);
			updateBtnStyle();
		}

		public function setLabelByID(tabID:int, newLabel:String):void
		{
			var btn:Button = btns[tabID] as Button;
			if (btn != null)
			{
				btn.label = newLabel;
			}
		}

		public function setLabelByIndex(index:int, newLabel:String):void
		{
			var btn:Button = this.getChildAt(index) as Button;
			if (btn != null)
			{
				btn.label = newLabel;
			}
		}

		public function getIDByIndex(index:int):int
		{
			var btn:Button = this.getChildAt(index) as Button;
			if (btn != null)
			{
				return StringUtil.pickIDFromName(btn.name);
			}
			else
			{
				return -1;
			}
		}

		public function getIndexByID(ID:int):int
		{
			var btn:Button = btns[ID] as Button;
			if (btn != null)
			{
				return this.getChildIndex(btn);
			}
			else
			{
				return -1;
			}
		}

		private function updateBtnStyle():void
		{
			for (var i:uint = this.numChildren ; --i >= 0 ; )
			{
				var btn:Button = this.getChildAt(i) as Button;
				if (i == this.numChildren - 1)
				{
					(btn.uiStyle as ButtonStyle).setAsNavigateRightButton();
				}
				else if (i == 0)
				{
					(btn.uiStyle as ButtonStyle).setAsNavigateLeftButton();
				}
				else
				{
					(btn.uiStyle as ButtonStyle).setAsNavigateNormalButton();
				}
			}
		}

		private function removeTab(btn:Button):void
		{
			if (btn != null)
			{
				delete btns[this.getIDByBtn(btn)];
				this.removeChild(btn);
				tabCount--;
				if (btn == currentSelectedBtn)
				{
					currentSelectedBtn = null;
					if (this.numChildren > 0)
					{
						var nextBtn:Button = this.getChildAt(0) as Button;
						if (nextBtn != null)
						{
							selectBtn(nextBtn, true);
						}
					}
				}
			}
		}

		private function createTab(label:String):Button
		{
			tabIDCount++;
			tabCount++;
			var btn:Button = new Button(label, new ButtonStyle());
			btn.name = "btn_" + tabIDCount;
			btn.selecteable = true;
			btn.percentHeight = 1;
			btn.autoWidth = true;
			btn.addEventListener(MouseEvent.CLICK, clickTabBtnHandler);
			btns[tabIDCount] = btn;
			return btn;
		}

		private function getIDByBtn(btn:Button):int
		{
			return StringUtil.pickIDFromName(btn.name);
		}

		private function selectBtn(btn:Button, dispatchEvent:Boolean = true):void
		{
			if (currentSelectedBtn != null)
			{
				currentSelectedBtn.selected = false;
			}
			currentSelectedBtn = btn;
			btn.selected = true;
			//
			if (dispatchEvent)
			{
				var btnID:int = StringUtil.pickIDFromName(btn.name);
				var ee:UIEvent = new UIEvent(UIEvent.CHANGE);
				ee.selectedID = btnID;
				ee.selectedIndex = this.getChildIndex(btn);
				this.dispatchEvent(ee);
			}
		}

		private function clickTabBtnHandler(e:MouseEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			if (btn != currentSelectedBtn)
			{
				selectBtn(btn, true);
			}
		}
	}
}
