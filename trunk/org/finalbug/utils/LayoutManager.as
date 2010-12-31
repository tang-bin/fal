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
package org.finalbug.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.style.LayoutStyle;
	
	/**
	 * LayoutManager
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class LayoutManager
	{
		//#######################################
		// SINGLETON
		//#######################################
		
		private static var instanceable:Boolean = false;
		private static var lm:LayoutManager;
		
		/**
		 * 
		 * @return 
		 */
		public static function get instance():LayoutManager
		{
			if(lm == null)
			{
				instanceable = true;
				lm = new LayoutManager();
				instanceable = false;
			}
			return lm;
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		private var list:Dictionary = new Dictionary();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @throws DataError
		 */
		public function LayoutManager()
		{
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param target
		 * @param data
		 */
		public function addLayout(target:DisplayObject, data:LayoutStyle):void
		{
			list[target] = data;
			data.owner = target;
		}
		
		/**
		 * 
		 * @param target
		 * @throws DataError
		 */
		public function removeLayout(target:DisplayObject):void
		{
			if(list[target] == null)
			{
				throw new DataError(DataError.DATA_NULL);
			}
			list[target] = null;
			delete list[target];
		}
		
		/**
		 * 
		 * @param root
		 */
		public function update(root:DisplayObject):void
		{
			if(root != null)
			{
				if(list[root] != null)
				{
					updateLayout(root);
				}
				if(root is DisplayObjectContainer)
				{
					var rootObj:DisplayObjectContainer = root as DisplayObjectContainer;
					for(var i:uint = rootObj.numChildren ; --i >= 0 ; )
					{
						var obj:DisplayObject = rootObj.getChildAt(i) as DisplayObject;
						update(obj);
					}
				}
			}
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function updateLayout(target:DisplayObject):void
		{
			var data:LayoutStyle = list[target] as LayoutStyle;
			target.width = data.width;
			target.height = data.height;
			target.x = data.x;
			target.y = data.y;
		}
		
		//#######################################
		// HANDLER
		//#######################################
	}
}