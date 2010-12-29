/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/
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
	 * @since 2010
	 */	
	public class CheckBoxSkinData extends UISkinDataBase
	{
		//***************************************
		// DEFINE
		//***************************************/
		
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
		
		private var box:SkinElement;
		private var label:Label;
		
		private var boxSkins:Dictionary;
		private var textFormats:Dictionary;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function CheckBoxSkinData()
		{
			super();
			//
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new checkBoxNormalCls(), true);
			boxSkins[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new checkBoxOverCls());
			boxSkins[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new checkBoxDownCls());
			boxSkins[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new checkBoxDisableCls());
			boxSkins[Status.SELECTED] = new SkinElementData(Status.SELECTED, SkinElementData.BITMAP_TYPE, new checkBoxSelectNormalCls());
			boxSkins[Status.SELECTED_MOUSE_OVER] = new SkinElementData(Status.SELECTED_MOUSE_OVER, SkinElementData.BITMAP_TYPE, new checkBoxSelectOverCls());
			boxSkins[Status.SELECTED_MOUSE_DOWN] = new SkinElementData(Status.SELECTED_MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new checkBoxSelectDownCls());
			boxSkins[Status.SELECTED_DISABLE] = new SkinElementData(Status.SELECTED_DISABLE, SkinElementData.BITMAP_TYPE, new checkBoxSelectDisableCls());
			//
			textFormats = new Dictionary();
			textFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		override public function setSkin(...args):void
		{
			box = args[0] as SkinElement;
			if(box != null)
			{
				this.setStatusSkinByList(box, boxSkins);
			}
			label = args[1] as Label;
			label.textFormat = textFormats[Status.NORMAL];
		}
		
		override public function setStatus(status:String):void
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