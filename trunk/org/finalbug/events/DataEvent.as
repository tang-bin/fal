//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.events
{
	import flash.events.Event;
	
	/**
	 * DataEvent
	 * 
	 * @author Tang Bin
	 * @since 2010.8
	 */	
	public class DataEvent extends Event
	{
		/**
		 * @eventType ChangeData
		 */		
		public static const CHANGE_DATA:String = "ChangeData";
		/**
		 * @eventType initEnd
		 */
		public static const INIT_END:String = "initEnd";
		
		/**
		 * 
		 * @default 
		 */
		public var dataPath:String = "";
		/**
		 * 
		 * @default 
		 */
		public var dataName:String = "";
		/**
		 * 
		 * @default 
		 */
		public var oldData:*;
		/**
		 * 
		 * @default 
		 */
		public var newData:*;
		/**
		 * 
		 * @default 
		 */
		public var dataStatus:String = "";
		
		// for tree model
		/**
		 * 
		 * @eventType treeAdd 
		 */
		public static const TREE_ADD:String = "treeAdd";
		/**
		 * 
		 * @eventType treeRemove
		 */
		public static const TREE_REMOVE:String = "treeRemove";
		/**
		 * 
		 * @eventType treeMove
		 */
		public static const TREE_MOVE:String = "treeMove";
		/**
		 * 
		 * @eventType treeChangeParent
		 */
		public static const TREE_CHANGE_PARENT:String = "treeChangeParent";
		/**
		 * 
		 * @eventType treeClean
		 */
		public static const TREE_CLEAN:String = "treeClean";
		/**
		 * 
		 * @eventType treeChange
		 */
		public static const TREE_CHANGE:String = "treeChange";
		
		/**
		 * 
		 * @default 
		 */
		public var treeNode:Object;
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}