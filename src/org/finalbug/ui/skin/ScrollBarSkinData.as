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
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.Status;
	
	/**
	 * ScrollBarSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */	
	public class ScrollBarSkinData extends UISkinDataAbstract
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
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
			if(leftBtn != null) bindStatusesToSkin(leftBtn, leftSkinData);
			if(rightBtn != null) bindStatusesToSkin(rightBtn, rightSkinData);
			if(upBtn != null) bindStatusesToSkin(upBtn, upSkinData);
			if(downBtn != null) bindStatusesToSkin(downBtn, downSkinData);
			if(back != null) bindStatusesToSkin(back, backSkinData);
			if(slider != null) bindStatusesToSkin(slider, sliderSkinData);
		}
		
		override public function changeStatus(status:String):void
		{
			if(leftBtn != null) leftBtn.status = status;
			if(rightBtn != null) rightBtn.status = status;
			if(upBtn != null) upBtn.status = status;
			if(downBtn != null) downBtn.status = status;
			if(back != null) back.status = status;
			if(slider != null) slider.status = status;
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		[Embed(source="/resources/skins/scrollBarUp_normal.png")]
		private var scrollBarUpNormalCls:Class;
		[Embed(source="/resources/skins/scrollBarUp_over.png")]
		private var scrollBarUpOverCls:Class;
		[Embed(source="/resources/skins/scrollBarUp_down.png")]
		private var scrollBarUpDownCls:Class;
		[Embed(source="/resources/skins/scrollBarUp_disable.png")]
		private var scrollBarUpDisableCls:Class;
		
		[Embed(source="/resources/skins/scrollBarDown_normal.png")]
		private var scrollBarDownNormalCls:Class;
		[Embed(source="/resources/skins/scrollBarDown_over.png")]
		private var scrollBarDownOverCls:Class;
		[Embed(source="/resources/skins/scrollBarDown_down.png")]
		private var scrollBarDownDownCls:Class;
		[Embed(source="/resources/skins/scrollBarDown_disable.png")]
		private var scrollBarDownDisableCls:Class;
		
		[Embed(source="/resources/skins/scrollBarLeft_normal.png")]
		private var scrollBarLeftNormalCls:Class;
		[Embed(source="/resources/skins/scrollBarLeft_over.png")]
		private var scrollBarLeftOverCls:Class;
		[Embed(source="/resources/skins/scrollBarLeft_down.png")]
		private var scrollBarLeftDownCls:Class;
		[Embed(source="/resources/skins/scrollBarLeft_disable.png")]
		private var scrollBarLeftDisableCls:Class;
		
		[Embed(source="/resources/skins/scrollBarRight_normal.png")]
		private var scrollBarRightNormalCls:Class;
		[Embed(source="/resources/skins/scrollBarRight_over.png")]
		private var scrollBarRightOverCls:Class;
		[Embed(source="/resources/skins/scrollBarRight_down.png")]
		private var scrollBarRightDownCls:Class;
		[Embed(source="/resources/skins/scrollBarRight_disable.png")]
		private var scrollBarRightDisableCls:Class;
		
		[Embed(source="/resources/skins/scrollBarSlider.png")]
		private var scrollBarSliderCls:Class;
		
		[Embed(source="/resources/skins/scrollBarBack_normal.png")]
		private var scrollBarBackNormalCls:Class;
		[Embed(source="/resources/skins/scrollBarBack_disable.png")]
		private var scrollBarBackDisableCls:Class;
		
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
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function ScrollBarSkinData()
		{
			leftSkinData = new Dictionary();
			leftSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarLeftNormalCls(), true);
			leftSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new scrollBarLeftOverCls());
			leftSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new scrollBarLeftDownCls());
			leftSkinData[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new scrollBarLeftDisableCls());
			//
			rightSkinData = new Dictionary();
			rightSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarRightNormalCls(), true);
			rightSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new scrollBarRightOverCls());
			rightSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new scrollBarRightDownCls());
			rightSkinData[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new scrollBarRightDisableCls());
			//
			upSkinData = new Dictionary();
			upSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarUpNormalCls(), true);
			upSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new scrollBarUpOverCls());
			upSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new scrollBarUpDownCls());
			upSkinData[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new scrollBarUpDisableCls());
			//
			downSkinData = new Dictionary();
			downSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarDownNormalCls(), true);
			downSkinData[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new scrollBarDownOverCls());
			downSkinData[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new scrollBarDownDownCls());
			downSkinData[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new scrollBarDownDisableCls());
			//
			backSkinData = new Dictionary();
			backSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarBackNormalCls(), true);
			backSkinData[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new scrollBarBackDisableCls());
			//
			sliderSkinData = new Dictionary();
			sliderSkinData[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new scrollBarSliderCls(), true);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
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