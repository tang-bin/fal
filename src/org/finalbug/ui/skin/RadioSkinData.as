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
		//#######################################
		// OVERRIDE
		//#######################################
		
		override public function bindChildren(...args):void
		{
			box = args[0] as Skin;
			if(box != null)
			{
				this.bindStatusesToSkin(box, boxSkins);
			}
			label = args[1] as Label;
			if(label != null)
			{
				label.textFormat = textFormats[Status.NORMAL] as TextFormat;
			}
		}
		
		override public function changeStatus(status:String):void
		{
			if(box != null)
			{
				box.status = status;
			}
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		[Embed(source="/resources/skins/radio_normal.png")]
		private var radioNormalCls:Class;
		[Embed(source="/resources/skins/radioSelect_normal.png")]
		private var radioSelectNormalCls:Class;
		[Embed(source="/resources/skins/radio_disable.png")]
		private var radioDisableCls:Class;
		[Embed(source="/resources/skins/radioSelect_normal.png")]
		private var radioSelectDisableCls:Class;
		
		// skin elements
		private var box:Skin;
		private var label:Label;
		
		// skin data
		private var boxSkins:Dictionary;
		private var textFormats:Dictionary;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function RadioSkinData()
		{
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new radioNormalCls(), true);
			boxSkins[Status.SELECTED] = new SkinData(Status.SELECTED, SkinData.BITMAP_TYPE, new radioSelectNormalCls());
			boxSkins[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new radioDisableCls());
			boxSkins[Status.SELECTED_DISABLE] = new SkinData(Status.SELECTED_DISABLE, SkinData.BITMAP_TYPE, new radioSelectDisableCls());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
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