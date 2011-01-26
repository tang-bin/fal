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
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	import org.finalbug.data.Status;

	/**
	 * TextSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class TextSkinData extends UISkinDataAbstract
	{

		// ******************* OVERRIDE *****************************
		override public function bindChildren(...args):void
		{
			box = args[0] as Skin;
			if (box != null)
			{
				this.bindStatusesToSkin(box, boxSkins);
			}
			text = args[1] as TextField;
			if (text != null)
			{
				text.setTextFormat(textFormats[Status.NORMAL]);
				text.defaultTextFormat = textFormats[Status.NORMAL];
			}
		}

		override public function changeStatus(status:String):void
		{
			if (box != null)
			{
				box.status = status;
			}
			if (text != null && textFormats[status] != null)
			{
				text.setTextFormat(textFormats[status]);
				text.defaultTextFormat = textFormats[status];
			}
		}

		// ******************* DEFINE *******************************
		[Embed(source="/resources/skins/TextNormal.png")]
		private var TextNormal:Class;

		[Embed(source="/resources/skins/TextForce.png")]
		private var TextForce:Class;

		[Embed(source="/resources/skins/TextDisabled.png")]
		private var TextDisabled:Class;

		// skin elements
		private var box:Skin;

		private var text:TextField;

		// skin data.
		private var boxSkins:Dictionary;

		private var textFormats:Dictionary;

		// extend skin data
		protected var scrollBarSkinData:ScrollBarSkinData;

		// ******************* GETTER and SETTER ********************
		// ******************* CONSTRUCTOR **************************.
		/**
		 * 
		 */
		public function TextSkinData()
		{
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new TextNormal(), true);
			boxSkins[Status.ACTIVE] = new SkinData(Status.ACTIVE, SkinData.BITMAP_TYPE, new TextForce());
			boxSkins[Status.DISABLED] = new SkinData(Status.DISABLED, SkinData.BITMAP_TYPE, new TextDisabled());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
			//
			scrollBarSkinData = new ScrollBarSkinData();
		}

		// ******************* PUBLIC *******************************
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