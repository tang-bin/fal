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
	import ftk.events.UIEvent;
	import ftk.layout.Container;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * NavigateTab, not finished.
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class NavigateTab extends Container
	{
		/**
		 * 
		 * @param skinData
		 */
		public function NavigateTab()
		{
			super();
			this.name = "navigate tab";
			// create children.
			bar = new NavigateBar();
			bar.addEventListener(UIEvent.CHANGE, clickToChangeTabHandler);
			//
			box = new Slider();
			box.backgroundAlpha = 1;
			box.backgroundColor = 0xFFFFFF;
			this.addAll(bar, box);
			//
			bar.layoutStyle.setRetangleStyle(0, 0, "100%", BUTTON_HEIGHT);
			box.layoutStyle.setAroundStyle(0, BUTTON_HEIGHT + BAR_SPACE, 0, 0);
		}

		/**
		 * 
		 * @default 
		 */
		protected const BUTTON_HEIGHT:Number = 20;

		/**
		 * 
		 * @default 
		 */
		protected const BAR_SPACE:Number = 5;

		private var bar:NavigateBar;

		private var box:Slider;

		private var tabs:Dictionary = new Dictionary();

		private var currentSelected:TabData;

		/**
		 * Add new tab into NavigateTab.
		 * 
		 * @param label Label string of new tab
		 * @param object Container of new tab. If null, an new Sprite object will be created and added to tab.
		 * @param index Index of new tab. -1 means added to the last.
		 * @return If object is not null, return object, or return the new Sprite object as DisplayObject.
		 */
		public function addTab(label:String, object:DisplayObject = null, index:int = -1):DisplayObject
		{
			var maxLen:uint = bar.numberTabs;
			if (index < 0 || index > maxLen)
			{
				index = maxLen;
			}
			//
			if (object == null)
			{
				object = new Sprite();
			}
			// create elements and data
			var data:TabData = new TabData();
			data.label = label;
			data.object = object;
			// add elements to display.
			if (index >= 0 && index < maxLen)
			{
				data.tabID = bar.addTabAt(index, label);
				box.addChildAt(data.object, index);
			}
			else
			{
				data.tabID = bar.addTab(label);
				box.addChild(data.object);
			}
			// save data into dictionary.
			tabs[data.tabID] = data;
			// change selected
			if (currentSelected == null)
			{
				doSelect(data);
			}
			//
			return object;
		}

		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabObjectAt(index:uint):DisplayObject
		{
			var tabData:TabData = this.getDataByIndex(index);
			if (tabData != null)
			{
				return tabData.object;
			}
			else
			{
				return null;
			}
		}

		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabLabelAt(index:uint):String
		{
			var tabData:TabData = this.getDataByIndex(index);
			if (tabData != null)
			{
				return tabData.label;
			}
			else
			{
				return null;
			}
		}

		/**
		 * 
		 * @param index
		 * @param label
		 */
		public function setTabLabelAt(index:uint, label:String):void
		{
			var tabData:TabData = this.getDataByIndex(index);
			if (tabData != null)
			{
				bar.setLabelByID(tabData.tabID, label);
				tabData.label = label;
			}
		}

		/**
		 * 
		 * @param object
		 * @param label
		 */
		public function setTabLabelByObject(object:DisplayObject, label:String):void
		{
			var tabData:TabData = getDataByObject(object);
			if (tabData != null)
			{
				bar.setLabelByID(tabData.tabID, label);
			}
		}

		/**
		 * 
		 * @param index
		 */
		public function removeTabAt(index:uint):void
		{
			var tabData:TabData = getDataByIndex(index);
			if (tabData != null)
			{
				removeTab(tabData);
			}
		}

		/**
		 * 
		 * @param object
		 */
		public function removeTabByObject(object:DisplayObject):void
		{
			var tabData:TabData = getDataByObject(object);
			if (tabData != null)
			{
				removeTab(tabData);
			}
		}

		private function doSelect(data:TabData):void
		{
			bar.selectedID = data.tabID;
			// select new
			box.selectedChild = data.object;
			// save select data.
			currentSelected = data;
		}

		private function getDataByIndex(index:uint):TabData
		{
			var ID:int = bar.getIDByIndex(index);
			return tabs[ID];
		}

		private function getDataByObject(object:DisplayObject):TabData
		{
			for each (var tabData:TabData in tabs)
			{
				if (tabData.object == object)
				{
					return tabData;
				}
			}
			return null;
		}

		private function removeTab(tabData:TabData):void
		{
			bar.removeTabByID(tabData.tabID);
			box.removeChild(tabData.object);
			if (tabData == currentSelected)
			{
				currentSelected = null;
			}
			delete tabs[tabData.tabID];
			tabs[tabData.tabID] = null;
		}

		private function clickToChangeTabHandler(e:UIEvent):void
		{
			trace(e.selectedID, e.selectedIndex);
			this.doSelect(tabs[e.selectedID]);
		}
	}
}
import flash.display.DisplayObject;

class TabData
{
	public var label:String;

	public var object:DisplayObject;

	public var tabID:uint;
}