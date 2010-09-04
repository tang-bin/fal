/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package fal.data
{
	
	/******************************************
	 * fal.data.TreeModel
	 *
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.09
	 *****************************************/
	public class TreeModel extends DataModel
	{
		/****************************************
		 *
		 * DEFINE
		 *
		 ****************************************/
		
		private var _root:Object = new Object();
		
		/****************************************
		 *
		 * GETTER & SETTER
		 *
		 ****************************************/
		
		public function get root():Object
		{
			return 
		}
		public function set root(value:Object):void
		{
			// TODO
		}
		
		/****************************************
		 *
		 * fal.data.TreeModel constructor.
		 *
		 ****************************************/
		public function TreeModel()
		{
			super();
		}
		
		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PUBLIC
		 *
		 ****************************************/
		
		public function addNode(parent:Object, node:Object):void
		{
			// TODO
		}
		
		public function removeNode(node:Object, removeChildrenOfNode:Boolean = true):void
		{
			// TODO
		}
		
		public function removeNodes(parent:Object):void
		{
			// TODO
		}
		
		public function getNodes(parent:Object):void
		{
			// TODO
		}
		
		public function changeNode(oldNode:Object, newNode:Object):void
		{
			// TODO
		}
		
		public function moveNode(node:Object, oldParent:Object, newParent:Object):void
		{
			// TODO
		}
		
		/****************************************
		 *
		 * PROTECTED
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * PRIVATE
		 *
		 ****************************************/
		
		/****************************************
		 *
		 * HANDLER
		 *
		 ****************************************/
	}
}