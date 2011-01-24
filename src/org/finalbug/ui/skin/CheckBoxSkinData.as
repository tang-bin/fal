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
	 * CheckBoxSkinData
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */	
	public class CheckBoxSkinData extends UISkinDataAbstract
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
			label.textFormat = textFormats[Status.NORMAL];
		}
		
		override public function changeStatus(status:String):void
		{
			if(box != null)
			{
				box.status = status;
			}
			if(label != null && textFormats[status] != null)
			{
				label.textFormat = textFormats[status];
			}
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		[Embed(source="/resources/skins/checkBox_normal.png")]
		private var checkBoxNormalCls:Class;
		[Embed(source="/resources/skins/checkBox_over.png")]
		private var checkBoxOverCls:Class;
		[Embed(source="/resources/skins/checkBox_down.png")]
		private var checkBoxDownCls:Class;
		[Embed(source="/resources/skins/checkBox_disable.png")]
		private var checkBoxDisableCls:Class;
		
		[Embed(source="/resources/skins/checkBoxSelect_normal.png")]
		private var checkBoxSelectNormalCls:Class;
		[Embed(source="/resources/skins/checkBoxSelect_over.png")]
		private var checkBoxSelectOverCls:Class;
		[Embed(source="/resources/skins/checkBoxSelect_down.png")]
		private var checkBoxSelectDownCls:Class;
		[Embed(source="/resources/skins/checkBoxSelect_disable.png")]
		private var checkBoxSelectDisableCls:Class;
		
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
		public function CheckBoxSkinData()
		{
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new checkBoxNormalCls(), true);
			boxSkins[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new checkBoxOverCls());
			boxSkins[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new checkBoxDownCls());
			boxSkins[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new checkBoxDisableCls());
			boxSkins[Status.SELECTED] = new SkinData(Status.SELECTED, SkinData.BITMAP_TYPE, new checkBoxSelectNormalCls());
			boxSkins[Status.SELECTED_MOUSE_OVER] = new SkinData(Status.SELECTED_MOUSE_OVER, SkinData.BITMAP_TYPE, new checkBoxSelectOverCls());
			boxSkins[Status.SELECTED_MOUSE_DOWN] = new SkinData(Status.SELECTED_MOUSE_DOWN, SkinData.BITMAP_TYPE, new checkBoxSelectDownCls());
			boxSkins[Status.SELECTED_DISABLE] = new SkinData(Status.SELECTED_DISABLE, SkinData.BITMAP_TYPE, new checkBoxSelectDisableCls());
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