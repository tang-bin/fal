/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.Status;
	
	/**
	 * ScrollBarSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class ScrollBarSkinData extends UISkinDataBase
	{
		//***************************************
		// DEFINE
		//***************************************/
		
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
		private var leftBtn:SkinElement;
		private var rightBtn:SkinElement;
		private var upBtn:SkinElement;
		private var downBtn:SkinElement;
		private var back:SkinElement;
		private var slider:SkinElement;
		
		// skin datas
		private var leftSkinData:Dictionary;
		private var rightSkinData:Dictionary;
		private var upSkinData:Dictionary;
		private var downSkinData:Dictionary;
		private var backSkinData:Dictionary;
		private var sliderSkinData:Dictionary;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function ScrollBarSkinData()
		{
			super();
			//
			leftSkinData = new Dictionary();
			leftSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarLeftNormalCls(), true);
			leftSkinData[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new scrollBarLeftOverCls());
			leftSkinData[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new scrollBarLeftDownCls());
			leftSkinData[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new scrollBarLeftDisableCls());
			//
			rightSkinData = new Dictionary();
			rightSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarRightNormalCls(), true);
			rightSkinData[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new scrollBarRightOverCls());
			rightSkinData[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new scrollBarRightDownCls());
			rightSkinData[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new scrollBarRightDisableCls());
			//
			upSkinData = new Dictionary();
			upSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarUpNormalCls(), true);
			upSkinData[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new scrollBarUpOverCls());
			upSkinData[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new scrollBarUpDownCls());
			upSkinData[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new scrollBarUpDisableCls());
			//
			downSkinData = new Dictionary();
			downSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarDownNormalCls(), true);
			downSkinData[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new scrollBarDownOverCls());
			downSkinData[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new scrollBarDownDownCls());
			downSkinData[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new scrollBarDownDisableCls());
			//
			backSkinData = new Dictionary();
			backSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarBackNormalCls(), true);
			backSkinData[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new scrollBarBackDisableCls());
			//
			sliderSkinData = new Dictionary();
			sliderSkinData[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new scrollBarSliderCls(), true);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		/**
		 * 
		 * @param args leftBtn, rightBtn, upBtn, downBtn, back, slider
		 * 
		 */		
		override public function setSkin(...args):void
		{
			leftBtn = args[0] as SkinElement;
			rightBtn = args[1] as SkinElement;
			upBtn = args[2] as SkinElement;
			downBtn = args[3] as SkinElement;
			back = args[4] as SkinElement;
			slider = args[5] as SkinElement;
			//
			if(leftBtn != null) setStatusSkinByList(leftBtn, leftSkinData);
			if(rightBtn != null) setStatusSkinByList(rightBtn, rightSkinData);
			if(upBtn != null) setStatusSkinByList(upBtn, upSkinData);
			if(downBtn != null) setStatusSkinByList(downBtn, downSkinData);
			if(back != null) setStatusSkinByList(back, backSkinData);
			if(slider != null) setStatusSkinByList(slider, sliderSkinData);
		}
		
		override public function setStatus(status:String):void
		{
			if(leftBtn != null) leftBtn.status = status;
			if(rightBtn != null) rightBtn.status = status;
			if(upBtn != null) upBtn.status = status;
			if(downBtn != null) downBtn.status = status;
			if(back != null) back.status = status;
			if(slider != null) slider.status = status;
		}
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}