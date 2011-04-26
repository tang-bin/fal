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
package ftk.layout
{
	import flash.display.DisplayObject;

	import ftk.core.Bin;
	import ftk.events.UIEvent;
	import ftk.style.FillStyle;

	/**
	 * Class Container is the basic class of the display object used to layout.
	 * Container contains basic method to position its children.
	 * 
	 * To learn more about the differents around Bin, Container and UIControl, see
	 * ftk.core.Bin.
	 * 
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class Container extends Bin
	{
		/**
		 * 
		 */
		public function Container()
		{
			super();
			_fillStyle = new FillStyle();
			this.initSize("100%", "100%");
			this.addEventListener(UIEvent.CHILDREN_CHANGED, childrenChangedHandler);
			this.addEventListener(UIEvent.CHILDREN_RESIZE, childrenChangedHandler);
		}

		private const HRank:String = "hRank";

		private const VRank:String = "vRank";

		private var _autoRank:Boolean = false;

		private var _autoRankSpace:Number = 0;

		private var _autoRankType:String = HRank;

		private var _autoRankCenter:Boolean = false;

		private var _autoRankPack:Boolean = false;

		public function get autoRank():Boolean
		{
			return _autoRank;
		}

		public function set autoRank(value:Boolean):void
		{
			if (value != _autoRank)
			{
				_autoRank = value;
				if (value)
				{
					doRank();
				}
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get backgroundColor():uint
		{
			return this.fillStyle.bgColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set backgroundColor(value:uint):void
		{
			this.fillStyle.bgColor = value;
			this.drawBg();
		}

		/**
		 * 
		 * @return 
		 */
		public function get backgroundAlpha():Number
		{
			return this.fillStyle.bgAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set backgroundAlpha(value:Number):void
		{
			this.fillStyle.bgAlpha = value;
			this.drawBg();
		}

		/**
		 * 
		 * @return 
		 */
		public function get borderColor():uint
		{
			return this.fillStyle.borderColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set borderColor(value:uint):void
		{
			this.fillStyle.borderColor = value;
			this.drawBg();
		}

		/**
		 * 
		 * @return 
		 */
		public function get borderAlpha():Number
		{
			return this.fillStyle.borderAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set borderAlpha(value:Number):void
		{
			this.fillStyle.borderAlpha = value;
			this.drawBg();
		}

		/**
		 * 
		 * @param space
		 * @param center
		 * @param packAfterRank
		 */
		public function horizontalRank(space:Number = 0, center:Boolean = true, packAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentX:Number = space;
			var maxHeight:Number = 0;
			for (var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.x = currentX;
				target.y = 0;
				currentX += target.width + space;
				if (target.height > maxHeight) maxHeight = target.height;
			}
			if (center)
			{
				for (var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxHeight - target2.height) / 2;
				}
			}
			if (packAfterRank)
			{
				pack(space, 0);
			}
			//
			_autoRankType = HRank;
			_autoRankCenter = center;
			_autoRankPack = packAfterRank;
			_autoRankSpace = space;
		}

		/**
		 * 
		 * @param space
		 * @param center
		 * @param packAfterRank
		 * 
		 */
		public function verticalRank(space:Number = 0, center:Boolean = true, packAfterRank:Boolean = false):void
		{
			var totalNum:uint = this.numChildren;
			var currentY:Number = space;
			var maxWidth:Number = 0;
			for (var i:uint = 0 ; i < totalNum ; i++)
			{
				var target:DisplayObject = this.getChildAt(i);
				target.y = currentY;
				target.x = 0;
				currentY += target.height + space;
				if (target.width > maxWidth) maxWidth = target.width;
			}
			if (center)
			{
				for (var j:uint = 0 ; j < totalNum ; j++)
				{
					var target2:DisplayObject = this.getChildAt(j);
					target2.y = (maxWidth - target2.width) / 2;
				}
			}
			if (packAfterRank)
			{
				pack(0, space);
			}
			//
			_autoRankType = VRank;
			_autoRankCenter = center;
			_autoRankPack = packAfterRank;
			_autoRankSpace = space;
		}

		private function childrenChangedHandler(e:UIEvent):void
		{
			if (this._autoRank)
			{
				doRank();
			}
		}

		private function doRank():void
		{
			if (this._autoRankType == HRank)
			{
				this.horizontalRank(_autoRankSpace, _autoRankCenter, _autoRankPack);
			}
			else if (this._autoRankType == VRank)
			{
				this.verticalRank(_autoRankSpace, _autoRankCenter, _autoRankPack);
			}
		}
	}
}