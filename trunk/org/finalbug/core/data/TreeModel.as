/******************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.core.data
{
	import org.finalbug.core.errors.DataError;
	
	import flash.utils.Dictionary;
	
	/******************************************
	 * org.finalbug.fal.data.TreeModel
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
		private var nodes:Dictionary = new Dictionary();
		
		/****************************************
		 *
		 * GETTER & SETTER
		 *
		 ****************************************/
		
		public function get root():Object
		{
			return _root;
		}
		public function set root(value:Object):void
		{
			_root = value;
		}
		
		/****************************************
		 *
		 * org.finalbug.fal.data.TreeModel constructor.
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
			if(hasNode(parent))
			{
				nodes[node] = parent;
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		public function removeNode(node:Object, removeChildrenOfNode:Boolean = true):void
		{
			if(nodes[node])
			{
				if(removeChildrenOfNode)
				{
					removeNodes(node);
				}
				else
				{
					changeParent(node, getParent(node));
				}
			}
			else if(node == _root)
			{
				_root = new Object();
				nodes = new Dictionary();
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		public function removeNodes(parent:Object):void
		{
			for(var key:Object in nodes)
			{
				if(nodes[key] == parent)
				{
					removeNodes(key);
					nodes[key] = null;
					delete nodes[key];
				}
			}
		}
		
		public function getNodes(parent:Object):Array
		{
			var arr:Array = new Array();
			for(var key:Object in nodes)
			{
				if(nodes[key] == parent)
				{
					arr.push(key)
				}
			}
			return arr;
		}
		
		public function changeNode(oldNode:Object, newNode:Object):void
		{
			if(nodes[newNode])
			{
				throw new DataError(DataError.DATA_NULL);
			}
			else if(!nodes[oldNode])
			{
				throw new DataError(DataError.DATA_NULL);
			}
			for(var key:Object in nodes)
			{
				if(nodes[key] == oldNode)
				{
					nodes[key] = newNode;
				}
				else if(key == oldNode)
				{
					nodes[newNode] = getParent(key);
					nodes[key] = null;
					delete nodes[key];
				}
			}
		}
		
		public function changeParent(oldParent:Object, newParent:Object):void
		{
			if(nodes[oldParent] && nodes[newParent])
			{
				for(var key:Object in nodes)
				{
					if(nodes[key] == oldParent)
					{
						nodes[key] = newParent;
					}
				}
			}
		}
		
		public function moveNode(node:Object, newParent:Object):void
		{
			if(!hasNode(newParent) || !nodes[node])
			{
				throw new DataError(DataError.DATA_NULL);
			}
			else
			{
				nodes[node] = newParent;
			}
		}
		
		public function getParent(node:Object):Object
		{
			if(node == _root)
			{
				return null;
			}
			else
			{
				return nodes[node];
			}
		}
		
		/****************************************
		 *
		 * PROTECTED
		 *
		 ****************************************/
		
		public function hasNode(node:Object):Boolean
		{
			return nodes[node] || node == _root;
		}
		
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