/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.events
{
	import flash.events.Event;

	public class DataEvent extends Event
	{
		/**
		 * @eventType ChangeData
		 */		
		public static const CHANGE_DATA:String = "ChangeData";
		public static const INIT_END:String = "initEnd";
		
		public var dataPath:String = "";
		public var dataName:String = "";
		public var oldData:*;
		public var newData:*;
		public var dataStatus:String = "";
		
		// for tree model
		public static const TREE_ADD:String = "treeAdd";
		public static const TREE_REMOVE:String = "treeRemove";
		public static const TREE_MOVE:String = "treeMove";
		public static const TREE_CHANGE_PARENT:String = "treeChangeParent";
		public static const TREE_CLEAN:String = "treeClean";
		public static const TREE_CHANGE:String = "treeChange";
		
		public var treeNode:Object;
		
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}