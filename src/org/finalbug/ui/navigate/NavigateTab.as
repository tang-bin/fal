// **********************************************************
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__ |     |__|___|  (____  /____/___  /____/\___  /
// \/             \/     \/         \/     /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.ui.navigate
{
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Container;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * NavigateTab, not finished.
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class NavigateTab extends Container
	{

		// ******************* OVERRIDE *****************************
		// ******************* DEFINE *******************************
		/**
		 * 
		 * @default 
		 */
		protected const BUTTON_HEIGHT:Number = 24;

		/**
		 * 
		 * @default 
		 */
		protected const BUTTON_SPACE:Number = 2;

		/**
		 * 
		 * @default 
		 */
		protected const BAR_SPACE:Number = 5;

		private var btnBar:Container;

		private var box:Slider;

		private var tabs:Dictionary = new Dictionary();

		private var currentSelected:TabData;

		// ******************* GETTER and SETTER ********************
		// ******************* CONSTRUCTOR **************************
		/**
		 * 
		 * @param skinData
		 */
		public function NavigateTab()
		{
			super();
			this.name = "navigate tab";
			// create children.
			btnBar = new Container();
			btnBar.horizontalRank(BUTTON_SPACE, true, false, true);
			//
			box = new Slider();
			box.borderAlpha = 1;
			box.borderColor = 0x333333;
			box.backgroundAlpha = 1;
			box.backgroundColor = 0xFFFFFF;
			this.addAll(btnBar, box);
			//
			btnBar.layoutStyle.setNormalStyle(0, 0, "100%", BUTTON_HEIGHT);
			box.layoutStyle.setAroundStyle(0, BUTTON_HEIGHT + BAR_SPACE, 0, 0);
		}

		// ******************* PUBLIC *******************************
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
			var maxLen:uint = btnBar.numChildren;
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
			// set button
			data.btn = new Button(label);
			data.btn.holdable = true;
			data.btn.percentHeight = 1;
			data.btn.autoWidth = true;
			data.btn.addEventListener(MouseEvent.CLICK, clickTabBtnHandler);
			// save data into dictionary.
			tabs[data.btn] = data;
			// add elements to display.
			if (index >= 0 && index < maxLen)
			{
				btnBar.addChildAt(data.btn, index);
				box.addChildAt(data.object, index);
			}
			else
			{
				btnBar.addChild(data.btn);
				box.addChild(data.object);
			}
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
				var btn:Button = tabData.btn;
				btn.label = label;
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
				tabData.btn.label = label;
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

		// ******************* PROTECTED ****************************
		// ******************* PRIVATE ******************************
		private function doSelect(data:TabData):void
		{
			// remove pre-selected
			if (currentSelected != null)
			{
				currentSelected.btn.hold = false;
			}
			// select new
			data.btn.hold = true;
			box.selectedChild = data.object;
			// save select data.
			currentSelected = data;
		}

		private function getDataByIndex(index:uint):TabData
		{
			var btn:Button = btnBar.getChildAt(index) as Button;
			if (btn != null)
			{
				return tabs[btn];
			}
			else
			{
				return null;
			}
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
			btnBar.removeChild(tabData.btn);
			box.removeChild(tabData.object);
			if (tabData == currentSelected)
			{
				currentSelected = null;
			}
			delete tabs[tabData.btn];
			tabs[tabData.btn] = null;
		}

		// ******************* HANDLER ******************************
		private function clickTabBtnHandler(e:MouseEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			if (btn != null)
			{
				this.doSelect(tabs[btn]);
			}
		}
	}
}
import org.finalbug.ui.control.Button;

import flash.display.DisplayObject;

class TabData
{

	/**
	 * 
	 * @default 
	 */
	public var label:String;

	/**
	 * 
	 * @default 
	 */
	public var object:DisplayObject;

	/**
	 * 
	 * @default 
	 */
	public var btn:Button;
}