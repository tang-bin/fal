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
	 * RadioSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class RadioSkinData extends UISkinDataAbstract
	{

		/******************* OVERRIDE **************************************************/
		override public function bindChildren(...args):void
		{
			box = args[0] as Skin;
			if (box != null)
			{
				this.bindStatusesToSkin(box, boxSkins);
			}
			label = args[1] as Label;
			if (label != null)
			{
				label.textFormat = textFormats[Status.NORMAL] as TextFormat;
			}
		}

		override public function changeStatus(status:String):void
		{
			if (box != null)
			{
				box.status = status;
			}
			if (label != null && textFormats[status] != null)
			{
				label.textFormat = textFormats[status] as TextFormat;
			}
		}

		/******************* DEFINE ****************************************************/
		[Embed(source="/resources/skins/RadioButtonNormal.png")]
		private var RadioButtonNormal:Class;

		[Embed(source="/resources/skins/RadioButtonSelectedNormal.png")]
		private var RadioButtonSelectedNormal:Class;

		[Embed(source="/resources/skins/RadioButtonSelectedDisabled.png")]
		private var RadioButtonSelectedDisabled:Class;

		[Embed(source="/resources/skins/RadioButtonDisabled.png")]
		private var RadioButtonDisabled:Class;

		// skin elements
		private var box:Skin;

		private var label:Label;

		// skin data
		private var boxSkins:Dictionary;

		private var textFormats:Dictionary;

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function RadioSkinData()
		{
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new RadioButtonNormal(), true);
			boxSkins[Status.SELECTED] = new SkinData(Status.SELECTED, SkinData.BITMAP_TYPE, new RadioButtonSelectedNormal());
			boxSkins[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new RadioButtonDisabled());
			boxSkins[Status.SELECTED_DISABLED] = new SkinData(Status.SELECTED_DISABLED, SkinData.BITMAP_TYPE, new RadioButtonSelectedDisabled());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Set RadioButton's skin style.
		 * This method should be called before transfer this object into any UI object.
		 * 
		 * @param status Valid status for Button:
		 * 				NORMAL,
		 * 				SELECTED,
		 * 				DISABLED,
		 * 				SELECTED_DISABLED.
		 * @param skinData SkinData for backgroud view.
		 * @param textFormat Text format for label.
		 */
		public function setSkinStyle(status:String, skinData:SkinData, textFormat:TextFormat):void
		{
			boxSkins[status] = skinData;
			textFormats[status] = textFormat;
		}
		/******************* PROTECTED *************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}