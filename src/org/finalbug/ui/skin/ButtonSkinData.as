// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.ui.skin
{
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	import org.finalbug.data.Status;
	import org.finalbug.ui.control.Label;

	/**
	 * ButtonSkin
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class ButtonSkinData extends UISkinDataAbstract
	{
		// #######################################
		// OVERRIDE
		// #######################################
		/**
		 * 
		 * @param args
		 */
		override public function bindChildren(...args):void
		{
			bgSkin = args[0] as Skin;
			if (bgSkin != null)
			{
				bindStatusesToSkin(bgSkin, bgSkinDataList);
			}
			label = args[1] as Label;
			if (label != null)
			{
				label.textFormat = txtFormatList[Status.NORMAL];
			}
		}

		/**
		 * 
		 * @param status
		 */
		override public function changeStatus(status:String):void
		{
			if (bgSkin != null)
			{
				bgSkin.status = status;
			}
			if (label != null && txtFormatList[status] != null)
			{
				label.textFormat = txtFormatList[status];
			}
		}

		// #######################################
		// DEFINE
		// #######################################
		[Embed(source="/resources/skins/ButtonNormal.png")]
		private var ButtonNormal:Class;
		[Embed(source="/resources/skins/ButtonOver.png")]
		private var ButtonOver:Class;
		[Embed(source="/resources/skins/ButtonDown.png")]
		private var ButtonDown:Class;
		[Embed(source="/resources/skins/ButtonDisabled.png")]
		private var ButtonDisabled:Class;
		[Embed(source="/resources/skins/ButtonHold.png")]
		private var ButtonHold:Class;
		[Embed(source="/resources/skins/ButtonHoldDown.png")]
		private var ButtonHoldDown:Class;
		[Embed(source="/resources/skins/ButtonHoldOver.png")]
		private var ButtonHoldOver:Class;
		// skin elements
		private var bgSkin:Skin;
		private var label:Label;
		// skin data.
		private var bgSkinDataList:Dictionary;
		private var txtFormatList:Dictionary;

		// #######################################
		// GETTER and SETTER
		// #######################################
		// #######################################
		// CONSTRUCTOR.
		// #######################################
		/**
		 * Create an new ButtonSkinData object.
		 */
		public function ButtonSkinData(empty:Boolean = false)
		{
			bgSkinDataList = new Dictionary();
			txtFormatList = new Dictionary();
			if (!empty)
			{
				// skin
				bgSkinDataList[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new ButtonNormal(), true);
				bgSkinDataList[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new ButtonOver());
				bgSkinDataList[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new ButtonDown());
				bgSkinDataList[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new ButtonDisabled());
				bgSkinDataList[Status.HOLD] = new SkinData(Status.HOLD, SkinData.BITMAP_TYPE, new ButtonHold());
				bgSkinDataList[Status.HOLD_MOUSE_DOWN] = new SkinData(Status.HOLD_MOUSE_DOWN, SkinData.BITMAP_TYPE, new ButtonHoldDown());
				bgSkinDataList[Status.HOLD_MOUSE_OVER] = new SkinData(Status.HOLD_MOUSE_OVER, SkinData.BITMAP_TYPE, new ButtonHoldOver());
				// text format
				txtFormatList[Status.NORMAL] = new TextFormat("Arial", 12, 0xFFFFFF, true);
			}
		}

		// #######################################
		// PUBLIC
		// #######################################
		/**
		 * Set Button's skin style.
		 * This method should be called before transfer this object into any UI object.
		 * 
		 * @param status Valid status for Button:
		 * 				NORMAL,
		 * 				MOUSE_DOWN,
		 * 				MOUSE_OVER,
		 * 				DISABLED,
		 * 				HOLD,
		 * 				HOLD_MOUSE_DOWN,
		 * 				HOLE_MOUSE_OVER. 
		 * @param skinData SkinData for backgroud view.
		 * @param textFormat Text format for label.
		 */
		public function setSkinStyle(status:String, skinData:SkinData, textFormat:TextFormat):void
		{
			bgSkinDataList[status] = skinData;
			txtFormatList[status] = textFormat;
		}
		// #######################################
		// PROTECTED
		// #######################################
		
		// #######################################
		// PRIVATE
		// #######################################
		
		// #######################################
		// HANDLER
		// #######################################
	}
}