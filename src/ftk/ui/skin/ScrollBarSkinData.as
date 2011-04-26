// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.ui.skin
{
	import flash.utils.Dictionary;
	import ftk.data.Status;


	/**
	 * ScrollBarSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class ScrollBarSkinData extends UISkinDataAbstract
	{

		/******************* OVERRIDE **************************************************/
		/**
		 * 
		 * @param args leftBtn, rightBtn, upBtn, downBtn, back, slider
		 * 
		 */
		override public function bindChildren(...args):void
		{
			leftBtn = args[0] as Skin;
			rightBtn = args[1] as Skin;
			upBtn = args[2] as Skin;
			downBtn = args[3] as Skin;
			back = args[4] as Skin;
			slider = args[5] as Skin;
			//
			if (leftBtn != null) bindStatusesToSkin(leftBtn, leftSkinData);
			if (rightBtn != null) bindStatusesToSkin(rightBtn, rightSkinData);
			if (upBtn != null) bindStatusesToSkin(upBtn, upSkinData);
			if (downBtn != null) bindStatusesToSkin(downBtn, downSkinData);
			if (back != null) bindStatusesToSkin(back, backSkinData);
			if (slider != null) bindStatusesToSkin(slider, sliderSkinData);
		}

		override public function changeStatus(status:String):void
		{
			if (leftBtn != null) leftBtn.status = status;
			if (rightBtn != null) rightBtn.status = status;
			if (upBtn != null) upBtn.status = status;
			if (downBtn != null) downBtn.status = status;
			if (back != null) back.status = status;
			if (slider != null) slider.status = status;
		}

		/******************* DEFINE ****************************************************/
		[Embed(source="/resources/skins/ScrollBarUpNormal.png")]
		private var ScrollBarUpNormal:Class;

		[Embed(source="/resources/skins/ScrollBarUpOver.png")]
		private var ScrollBarUpOver:Class;

		[Embed(source="/resources/skins/ScrollBarUpDown.png")]
		private var ScrollBarUpDown:Class;

		[Embed(source="/resources/skins/ScrollBarUpDisabled.png")]
		private var ScrollBarUpDisable:Class;

		[Embed(source="/resources/skins/ScrollBarDownNormal.png")]
		private var ScrollBarDownNormal:Class;

		[Embed(source="/resources/skins/ScrollBarDownOver.png")]
		private var ScrollBarDownOver:Class;

		[Embed(source="/resources/skins/ScrollBarDownDown.png")]
		private var ScrollBarDownDown:Class;

		[Embed(source="/resources/skins/ScrollBarDownDisabled.png")]
		private var ScrollBarDownDisable:Class;

		[Embed(source="/resources/skins/ScrollBarLeftNormal.png")]
		private var ScrollBarLeftNormal:Class;

		[Embed(source="/resources/skins/ScrollBarLeftOver.png")]
		private var ScrollBarLeftOver:Class;

		[Embed(source="/resources/skins/ScrollBarLeftDown.png")]
		private var ScrollBarLeftDown:Class;

		[Embed(source="/resources/skins/ScrollBarLeftDisabled.png")]
		private var ScrollBarLeftDisable:Class;

		[Embed(source="/resources/skins/ScrollBarRightNormal.png")]
		private var ScrollBarRightNormal:Class;

		[Embed(source="/resources/skins/ScrollBarRightOver.png")]
		private var ScrollBarRightOver:Class;

		[Embed(source="/resources/skins/ScrollBarRightDown.png")]
		private var ScrollBarRightDown:Class;

		[Embed(source="/resources/skins/ScrollBarRightDisabled.png")]
		private var ScrollBarRightDisable:Class;

		[Embed(source="/resources/skins/ScrollBarSlider.png")]
		private var ScrollBarSlider:Class;

		[Embed(source="/resources/skins/ScrollBarBackNormal.png")]
		private var ScrollBarBackNormal:Class;

		[Embed(source="/resources/skins/ScrollBarBackDisabled.png")]
		private var ScrollBarBackDisable:Class;

		// skin elements
		private var leftBtn:Skin;

		private var rightBtn:Skin;

		private var upBtn:Skin;

		private var downBtn:Skin;

		private var back:Skin;

		private var slider:Skin;

		// skin data
		private var leftSkinData:Dictionary;

		private var rightSkinData:Dictionary;

		private var upSkinData:Dictionary;

		private var downSkinData:Dictionary;

		private var backSkinData:Dictionary;

		private var sliderSkinData:Dictionary;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function ScrollBarSkinData()
		{
			leftSkinData = new Dictionary();
			leftSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarLeftNormal(), true);
			leftSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new ScrollBarLeftOver());
			leftSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new ScrollBarLeftDown());
			leftSkinData[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ScrollBarLeftDisable());
			//
			rightSkinData = new Dictionary();
			rightSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarRightNormal(), true);
			rightSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new ScrollBarRightOver());
			rightSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new ScrollBarRightDown());
			rightSkinData[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ScrollBarRightDisable());
			//
			upSkinData = new Dictionary();
			upSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarUpNormal(), true);
			upSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new ScrollBarUpOver());
			upSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new ScrollBarUpDown());
			upSkinData[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ScrollBarUpDisable());
			//
			downSkinData = new Dictionary();
			downSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarDownNormal(), true);
			downSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new ScrollBarDownOver());
			downSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new ScrollBarDownDown());
			downSkinData[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ScrollBarDownDisable());
			//
			backSkinData = new Dictionary();
			backSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarBackNormal(), true);
			backSkinData[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ScrollBarBackDisable());
			//
			sliderSkinData = new Dictionary();
			sliderSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ScrollBarSlider(), true);
		}

		/******************* PUBLIC ****************************************************/
		public function setSkinStyle(status:String, leftSkin:SkinData = null, rightSkin:SkinData = null, upSkin:SkinData = null, downSkin:SkinData = null, backSkin:SkinData = null, sliderSkin:SkinData = null):void
		{
			leftSkinData[status] = leftSkin;
			rightSkinData[status] = rightSkin;
			upSkinData[status] = upSkin;
			downSkinData[status] = downSkin;
			backSkinData[status] = backSkin;
			sliderSkinData[status] = sliderSkin;
		}
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}