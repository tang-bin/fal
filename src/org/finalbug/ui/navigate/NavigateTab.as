//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.navigate
{
	import flash.display.DisplayObject;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Container;
	import org.finalbug.ui.control.UIObject;
	import org.finalbug.ui.skin.UISkinDataBase;
	
	
	/**
	 * NavigateTab, not finished.
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */	
	public class NavigateTab extends UIObject
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var btnBar:Container;
		private var box:Slider;
		
		private var tabs:Array = new Array();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 * @param skinData
		 */
		public function NavigateTab(skinData:UISkinDataBase=null)
		{
			super(skinData);
			// create children.
			btnBar = new Container();
			btnBar.horizontalRank(0, true, false, true);
			box = new Slider();
			this.addAll(btnBar, box);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param label
		 * @param object
		 * @param index
		 */
		public function addTab(label:String, object:DisplayObject = null, index:int = -1):void
		{
			if(index < 0 || index > tabs.length)
			{
				index = tabs.length;
			}
			//
			var data:TabData = new TabData();
			data.label = label;
			data.object = object;
			data.btn = new Button(label);
			tabs.splice(index, 0, data);
			//
			btnBar.addChild(data.btn);
			box.addChild(data.object);
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabObjectAt(index:uint):DisplayObject
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			return (tabs[index] as TabData).object;
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabLabelAt(index:uint):String
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			return (tabs[index] as TabData).label;
		}
		
		/**
		 * 
		 * @param index
		 * @param label
		 */
		public function setTabLabelAt(index:uint, label:String):void
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			
		}
		
		/**
		 * 
		 * @param object
		 * @param label
		 */
		public function setTabLabelByObject(object:DisplayObject, label:String):void
		{
			
		}
		
		/**
		 * 
		 * @param index
		 */
		public function removeTabAt(index:uint):void
		{
			
		}
		
		/**
		 * 
		 * @param object
		 */
		public function removeTabByObject(object:DisplayObject):void
		{
			
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}
import flash.display.DisplayObject;

import org.finalbug.ui.control.Button;

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