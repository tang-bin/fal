// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * [fb-aslib] Finalbug ActionScript Library
// * http://www.finalbug.org
// **********************************************************
package org.finalbug.ui.skin
{
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	import org.finalbug.data.Status;
	import org.finalbug.ui.control.Label;

	/**
	 * CheckBoxSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class CheckBoxSkinData extends UISkinDataAbstract
	{

		// ******************* OVERRIDE *****************************
		override public function bindChildren(...args):void
		{
			box = args[0] as Skin;
			if (box != null)
			{
				this.bindStatusesToSkin(box, boxSkins);
			}
			label = args[1] as Label;
			label.textFormat = textFormats[Status.NORMAL];
		}

		override public function changeStatus(status:String):void
		{
			if (box != null)
			{
				box.status = status;
			}
			if (label != null && textFormats[status] != null)
			{
				label.textFormat = textFormats[status];
			}
		}

		// ******************* DEFINE *******************************
		[Embed(source="/resources/skins/CheckBoxNormal.png")]
		private var CheckBoxNormal:Class;

		[Embed(source="/resources/skins/CheckBoxOver.png")]
		private var CheckBoxOver:Class;

		[Embed(source="/resources/skins/CheckBoxDown.png")]
		private var CheckBoxDown:Class;

		[Embed(source="/resources/skins/CheckBoxDisabled.png")]
		private var CheckBoxDisabled:Class;

		[Embed(source="/resources/skins/CheckBoxSelectNormal.png")]
		private var CheckBoxSelectNormal:Class;

		[Embed(source="/resources/skins/CheckBoxSelectOver.png")]
		private var CheckBoxSelectOver:Class;

		[Embed(source="/resources/skins/CheckBoxSelectDown.png")]
		private var CheckBoxSelectDown:Class;

		[Embed(source="/resources/skins/CheckBoxSelectDisabled.png")]
		private var CheckBoxSelectDisabled:Class;

		// skin elements
		private var box:Skin;

		private var label:Label;

		// skin data
		private var boxSkins:Dictionary;

		private var textFormats:Dictionary;

		// ******************* GETTER and SETTER ********************
		// ******************* CONSTRUCTOR **************************.
		/**
		 * 
		 */
		public function CheckBoxSkinData()
		{
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new CheckBoxNormal(), true);
			boxSkins[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new CheckBoxOver());
			boxSkins[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new CheckBoxDown());
			boxSkins[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new CheckBoxDisabled());
			boxSkins[Status.SELECTED] = new SkinData(Status.SELECTED, SkinData.BITMAP_TYPE, new CheckBoxSelectNormal());
			boxSkins[Status.SELECTED_MOUSE_OVER] = new SkinData(Status.SELECTED_MOUSE_OVER, SkinData.BITMAP_TYPE, new CheckBoxSelectOver());
			boxSkins[Status.SELECTED_MOUSE_DOWN] = new SkinData(Status.SELECTED_MOUSE_DOWN, SkinData.BITMAP_TYPE, new CheckBoxSelectDown());
			boxSkins[Status.SELECTED_DISABLED] = new SkinData(Status.SELECTED_DISABLED, SkinData.BITMAP_TYPE, new CheckBoxSelectDisabled());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
		}

		// ******************* PUBLIC *******************************
		/**
		 * Set CheckBox's skin style.
		 * This method should be called before transfer this object into any UI object.
		 * 
		 * @param status Valid status for Button:
		 * 				NORMAL,
		 * 				MOUSE_DOWN,
		 * 				MOUSE_OVER,
		 * 				DISABLED,
		 * 				SELECTED,
		 * 				SELECTED_MOUSE_OVER,
		 * 				SELECTED_MOUSE_DOWN,
		 * 				SELECTED_DISABLED. 
		 * @param skinData SkinData for backgroud view.
		 * @param textFormat Text format for label.
		 */
		public function setSkinStyle(status:String, skinData:SkinData, textFormat:TextFormat):void
		{
			boxSkins[status] = skinData;
			textFormats[status] = textFormat;
		}
		// ******************* PROTECTED ****************************
		
		
		
		// ******************* PRIVATE ******************************
		
		
		
		// ******************* HANDLER ******************************
	}
}