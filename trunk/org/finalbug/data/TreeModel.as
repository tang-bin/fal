/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	import flash.utils.Dictionary;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.events.DataEvent;
	import org.finalbug.utils.StringUtil;
	
	/******************************************************
	 * data.TreeModel
	 *
	 * @author Tang Bin
	 * @since 2010.09
	 ******************************************************/  
	public class TreeModel extends DataModel
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public var nodeToStringFunction:Function;
		/**
		 * 
		 * @default 
		 */
		public var stringToNodeFunction:Function;
		
		private var _root:NodeData;
		private var nodes:Dictionary;
		private var _xml:XML;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * Root data object
		 */		
		public function get root():Object
		{
			return _root.data;
		}
		/**
		 * 
		 * @param value
		 */
		public function set root(value:Object):void
		{
			_root.data = value;
		}
		
		/**
		 * Define a treeModel by XML.
		 * e.g., use XML <node name="a11">aa11</node> to define one tree node,
		 * and you can get the node object by using method getNodeByAttribute.
		 * node's name is saved in node object's "nodeName" attribute, 
		 * and node's value is saved in node object's "nodeValue" attribue.
		 */		
		public function get xml():XML
		{
			if(_xml == null)
			{
				return getTempXML();
			}
			else
			{
				return _xml;
			}
		}
		/**
		 * 
		 * @param value
		 */
		public function set xml(value:XML):void
		{
			_xml = value;
			this.clean();
			//
			var rootChildren:XMLList = _xml.children();
			var len:uint = rootChildren.length();
			var index:uint;
			for(index = 0 ; index < len ; index++)
			{
				addXMLDataToTree(_root, rootChildren[index]);
			}
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 */
		public function TreeModel()
		{
			super();
			clean();
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * add an new node to tree.
		 * 
		 * @param parent Node's parent node.
		 * @param node Node object
		 */		
		public function addNode(parent:Object, node:Object):void
		{
			var parentData:NodeData = nodes[parent] as NodeData;
			if(parentData != null)
			{
				var nd:NodeData = new NodeData();
				nd.parent = parentData;
				nd.data = node;
				//
				var lastData:NodeData = this.getLastChild(parentData);
				if(lastData != null)
				{
					nd.prev = lastData;
					lastData.next = nd;
				}
				else
				{
					parentData.firstChild = nd;
				}
				parentData.numChildren += 1;
				nodes[node] = nd;
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Remove one node from tree, all subnodes will be removed, too.
		 * @param node
		 * 
		 */		
		public function removeNode(node:Object):void
		{
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				var nextNode:NodeData = getNodeByData(nodeData.firstChild);
				while(nextNode != null)
				{
					removeNode(nextNode.data);
					nextNode = getNodeByData(nextNode.next);
				}
				var parentData:NodeData = getNodeByData(nodeData.parent);
				if(parentData != null)
				{
					parentData.numChildren -= 1;
					if(parentData.firstChild == node)
					{
						parentData.firstChild = nodeData.next;
					}
				}
				nodes[node] = null;
				delete nodes[node];
			}
			else if(node == _root.data)
			{
				this.clean();
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Remove all subnodes of a node.
		 * To remove all nodes of the tree, use method clean().
		 */		
		public function removeAllChildren(parent:Object):void
		{
			var nodeData:NodeData = getNodeByData(parent);
			if(parent == _root.data)
			{
				_root.numChildren = 0;
				_root.firstChild = null;
				nodes = new Dictionary();
			}
			else if(nodeData != null)
			{
				var nextNode:NodeData = getNodeByData(nodeData.firstChild);
				while(nextNode != null)
				{
					removeNode(nextNode.data);
					nextNode = getNodeByData(nextNode.next);
				}
				nodeData.firstChild = null;
				nodeData.numChildren = 0;
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Get one node's subnodes. In order.
		 * 
		 * @param parent
		 * @return 
		 */		
		public function getNodes(parent:Object):Array
		{
			var arr:Array = new Array();
			var parentData:NodeData = getNodeByData(parent);
			if(parentData != null)
			{
				var nodeData:NodeData = parentData.firstChild;
				while(nodeData != null)
				{
					arr.push(nodeData.data);
					nodeData = nodeData.next;
				}
			}
			return arr;
		}
		
		/**
		 * Get one node's children number.
		 * 
		 * @param parent
		 * @return 
		 */		
		public function getNumChildren(parent:Object):uint
		{
			var parentData:NodeData = getNodeByData(parent);
			if(parentData != null)
			{
				return parentData.numChildren;
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Get node's next node.
		 * 
		 * @param node
		 * @return Return null if no next node 
		 */		
		public function getNextNode(node:Object):Object
		{
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				if(nodeData.next != null)
				{
					return nodeData.next.data;
				}
				else
				{
					return null;
				}
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Get node's previous node.
		 * 
		 * @param node
		 * @return Return null if no previous node. 
		 */		
		public function getPreviousNode(node:Object):Object
		{
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				if(nodeData.prev != null)
				{
					return nodeData.prev.data;
				}
				else
				{
					return null;
				}
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Get nodes by thire attributes.
		 * 
		 * @param attributeName
		 * @param value
		 * @return A list of nodes.
		 */		
		public function getNodeByAttribute(attributeName:String, value:*):Array
		{
			var arr:Array = new Array();
			for each(var nd:NodeData in nodes)
			{
				if(nd.data.hasOwnProperty(attributeName) && nd.data[attributeName] == value)
				{
					arr.push(nd.data);
				}
			}
			return arr;
		}
		
		/**
		 * Move node up
		 * 
		 * @param node
		 * @param step
		 */		
		public function moveUpNode(node:Object, step:uint = 1):void
		{
			if(node == _root.data) return;
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				if(nodeData.prev != null)
				{
					if(nodeData.prev.prev != null)
					{
						var node1:NodeData = nodeData.prev.prev;
						var node2:NodeData = nodeData.prev;
						node1.next = nodeData;
						node2.prev = nodeData;
						node2.next = nodeData.next;
						nodeData.prev = node1;
						nodeData.next = node2;
						if(step > 1)
						{
							moveUpNode(node, step - 1);
						}
					}
					else
					{
						// nodeData's previous node is the firstchild of parent.
						nodeData.prev.next = nodeData.next;
						nodeData.next = nodeData.prev;
						nodeData.prev = null;
						nodeData.parent.firstChild = nodeData;
					}
				}
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Move mode down.
		 * 
		 * @param node
		 * @param step
		 */		
		public function moveDownNode(node:Object, step:uint = 1):void
		{
			if(node == _root.data) return;
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				if(nodeData.next != null)
				{
					if(nodeData.prev != null)
					{
						var node1:NodeData = nodeData.prev
						var node2:NodeData = nodeData.next;
						node1.next = node2;
						nodeData.prev = node2;
						nodeData.next = node2.next;
						node2.prev = node1;
						node2.next = nodeData;
					}
					else
					{
						// nodeData's next node is the last of parent
						var node3:NodeData = nodeData.next;
						nodeData.prev = node3;
						nodeData.next = node3.next;
						node3.prev = null;
						node3.next = nodeData;
						nodeData.parent.firstChild = node3;
					}
					if(step > 1)
					{
						moveDownNode(node, step - 1);
					}
				}
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Move node to the first child of parent.
		 * 
		 * @param node
		 */		
		public function moveModeToFirst(node:Object):void
		{
			if(node == _root.data) return;
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				this.moveUpNode(node, nodeData.parent.numChildren);
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Move node to the last child of parent.
		 * 
		 * @param node
		 */		
		public function moveModeToLast(node:Object):void
		{
			if(node == _root.data) return;
			var nodeData:NodeData = getNodeByData(node);
			if(nodeData != null)
			{
				this.moveDownNode(node, nodeData.parent.numChildren);
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * Change node's object, but not change node's position.
		 * 
		 * @param oldNode
		 * @param newNode
		 */		
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
			var nodeData:NodeData = getNodeByData(oldNode);
			nodeData.data = newNode;
		}
		
		/**
		 * change node's parent.
		 *  
		 * @param node
		 * @param newParent
		 * 
		 */		
		public function changeParent(node:Object, newParent:Object):void
		{
			var nodeData:NodeData = this.getNodeByData(node);
			var parentData:NodeData = this.getNodeByData(newParent);
			if(nodeData != null && parentData != null)
			{
				this.takeOutNode(nodeData);
				this.takeOnNode(nodeData, parentData);
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		/**
		 * trace all nodes as one tree.
		 */		
		public function traceAll():void
		{
			traceNode(_root, 0);
		}
		
		/**
		 * remove all node and create new root. 
		 */		
		public function clean():void
		{
			_root = new NodeData();
			_root.data = new Object();
			nodes = new Dictionary();
			nodes[_root.data] = _root;
			//
			var ee:DataEvent = new DataEvent(DataEvent.TREE_CLEAN);
			this.dispatchEvent(ee);
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 * 
		 * @param node
		 * @return 
		 */
		protected function hasNode(node:Object):Boolean
		{
			return nodes[node] || node == _root.data;
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function getNodeByData(data:Object):NodeData
		{
			if(data == null) return null;
			return nodes[data] as NodeData;
		}
		
		private function getLastChild(data:NodeData):NodeData
		{
			if(data != null && data.firstChild != null)
			{
				var nextData:NodeData = data.firstChild;
				var currentData:NodeData;
				while(nextData != null)
				{
					currentData = nextData;
					nextData = nextData.next;
				}
				return currentData;
			}
			else
			{
				return null;
			}
		}
		
		private function takeOutNode(nodeData:NodeData):void
		{
			if(nodeData != null)
			{
				var prev:NodeData = nodeData.prev;
				var next:NodeData = nodeData.next
				if(prev != null && next != null)
				{
					prev.next = next;
					next.prev = prev
				}
				else if(prev != null)
				{
					prev.next = null;
				}
				else if(next != null)
				{
					nodeData.parent.firstChild = next;
					next.prev = null;
				}
				nodeData.prev = nodeData.next = nodeData.parent = null;
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		private function takeOnNode(nodeData:NodeData, parentData:NodeData):void
		{
			nodeData.parent = parentData;
			if(parentData.numChildren > 0)
			{
				var lastNode:NodeData = this.getLastChild(parentData);
				lastNode.next = nodeData;
				nodeData.prev = lastNode;
			}
			else
			{
				parentData.firstChild = nodeData;
			}
			parentData.numChildren += 1;
		}
		
		private function traceNode(nodeData:NodeData, lv:uint):void
		{
			var str:String = "";
			str += StringUtil.getBlankSpace(lv * 2);
			str += "|-> "
			if(nodeData.data.hasOwnProperty("name"))
			{
				str += nodeData.data["name"].toString();
			}
			else
			{
				str += nodeData.data.toString();
			}
			// !! DO NOT remove trace line.
			trace(str);
			if(nodeData.numChildren > 0)
			{
				traceNode(nodeData.firstChild, lv + 1);
			}
			if(nodeData.next != null)
			{
				traceNode(nodeData.next, lv);
			}
		}
		
		private function getTempXML():XML
		{
			var str:String = "<t>";
			str += getNextTempXML(_root);
			str += "</t>"
			return new XML(str);
		}
		
		private function getNextTempXML(node:NodeData):String
		{
			var str:String = "";
			var nodeStr:String = nodeToStringFunction != null ? nodeToStringFunction.call(node.data) : node.data.toString();
			str += "<n v=\"" + escape(nodeStr) + "\"/>";
			if(node.firstChild != null)
			{
				str += getNextTempXML(node.firstChild);
			}
			str += "</n>";
			if(node.next != null)
			{
				str += getNextTempXML(node.next);
			}
			return str;
		}
		
		private function addXMLDataToTree(parentData:NodeData, xmlData:XML):void
		{
			var newObj:Object = this.getObjectByXML(xmlData);
			if(newObj != null)
			{
				this.addNode(parentData.data, newObj);
				var newNode:NodeData = getNodeByData(newObj);
				//
				var children:XMLList = xmlData.children();
				var len:uint = children.length();
				var index:uint = 0;
				for(index = 0 ; index < len ; index++)
				{
					var childXML:XML = children[index];
					addXMLDataToTree(newNode, childXML);
				}
			}
		}
		
		private function getObjectByXML(xmlData:XML):Object
		{
			var obj:Object = new Object();
			if(xmlData.name() != null)
			{
				var attrs:XMLList = xmlData.attributes();
				var len:uint = attrs.length();
				var index:uint;
				for(index = 0 ; index < len ; index++)
				{
					var attrName:String = attrs[index].name();
					obj[attrName] = attrs[index];
				}
				obj.nodeName = xmlData.name();
				obj.nodeValue = xmlData.children();
				return obj;
			}
			else
			{
				return null;
			}
		}
		
		//#######################################
		// HANDLER
		//#######################################
	}
}
class NodeData
{
	/**
	 * 
	 * @default 
	 */
	public var data:Object;
	/**
	 * 
	 * @default 
	 */
	public var prev:NodeData;
	/**
	 * 
	 * @default 
	 */
	public var next:NodeData;
	/**
	 * 
	 * @default 
	 */
	public var parent:NodeData;
	/**
	 * 
	 * @default 
	 */
	public var firstChild:NodeData;
	/**
	 * 
	 * @default 
	 */
	public var numChildren:uint = 0;
}