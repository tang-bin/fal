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
	import ftk.errors.DataError;
	import ftk.layout.Container;

	import flash.display.DisplayObject;

	/**
	 * Slider. similer with mx component ViewStack.
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */
	public class Slider extends Container
	{
		/**
		 * 
		 */
		public function Slider()
		{
			super();
			this.initSize("100%", "100%");
		}

		/**
		 * 
		 * @param child
		 * @return 
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var addedChild:DisplayObject = super.addChild(child);
			addedChild.visible = false;
			refreshIndex();
			return addedChild;
		}

		/**
		 * 
		 * @param child
		 * @param index
		 * @return 
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var addedChild:DisplayObject = super.addChildAt(child, index);
			addedChild.visible = false;
			refreshIndex();
			return addedChild;
		}

		/**
		 * 
		 * @param child
		 * @return 
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var removedChild:DisplayObject = super.removeChild(child);
			refreshIndex();
			return removedChild;
		}

		/**
		 * 
		 * @param index
		 * @return 
		 */
		override public function removeChildAt(index:int):DisplayObject
		{
			var removedChild:DisplayObject = super.removeChildAt(index);
			refreshIndex();
			return removedChild;
		}

		/**
		 * 
		 */
		override protected function updateSize():void
		{
			super.updateSize();
			for (var i:uint = this.numChildren ; --i >= 0 ; )
			{
				var child:DisplayObject = this.getChildAt(i);
				child.width = this.width;
				child.height = this.height;
			}
		}

		private var _selectedIndex:int = -1;

		private var _selectedChild:DisplayObject = null;

		/**
		 * 
		 * @return 
		 */
		public function get selectedChild():DisplayObject
		{
			return _selectedChild;
		}

		/**
		 * 
		 * @param child
		 */
		public function set selectedChild(child:DisplayObject):void
		{
			if (this.contains(child))
			{
				var index:uint = this.getChildIndex(child);
				setShowChildIndex(index);
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		/**
		 * 
		 * @param index
		 */
		public function set selectedIndex(index:int):void
		{
			setShowChildIndex(index);
		}

		private function setShowChildIndex(index:int):void
		{
			if (_selectedIndex != index)
			{
				if (index >= this.numChildren || index < -1)
				{
					throw new DataError(DataError.INVALID_INDEX);
				}
				_selectedIndex = index;
				if (_selectedChild != null)
				{
					_selectedChild.visible = false;
				}
				if (_selectedIndex >= 0)
				{
					_selectedChild = this.getChildAt(index);
					_selectedChild.visible = true;
				}
				else
				{
					_selectedChild = null;
				}
			}
		}

		private function refreshIndex():void
		{
			if (_selectedChild != null && this.contains(_selectedChild))
			{
				_selectedIndex = this.getChildIndex(_selectedChild);
			}
			else
			{
				_selectedChild = null;
				_selectedIndex = -1;
			}
			setShowChildIndex(_selectedIndex);
		}
	}
}