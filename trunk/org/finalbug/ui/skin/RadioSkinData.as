/******************************************
 * Tang Bin
 *****************************************/
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
	 * @since 2010
	 */	
	public class RadioSkinData extends UISkinDataBase
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		[Embed(source="/resources/skins/radio_normal.png")]
		private var radioNormalCls:Class;
		[Embed(source="/resources/skins/radioSelect_normal.png")]
		private var radioSelectNormalCls:Class;
		[Embed(source="/resources/skins/radio_disable.png")]
		private var radioDisableCls:Class;
		[Embed(source="/resources/skins/radioSelect_normal.png")]
		private var radioSelectDisableCls:Class;
		
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
		
		public function RadioSkinData()
		{
			super();
			//
			boxSkins = new Dictionary();
			boxSkins[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new radioNormalCls(), true);
			boxSkins[Status.SELECTED] = new SkinElementData(Status.SELECTED, SkinElementData.BITMAP_TYPE, new radioSelectNormalCls());
			boxSkins[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new radioDisableCls());
			boxSkins[Status.SELECTED_DISABLE] = new SkinElementData(Status.SELECTED_DISABLE, SkinElementData.BITMAP_TYPE, new radioSelectDisableCls());
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
			if(label != null)
			{
				label.textFormat = textFormats[Status.NORMAL] as TextFormat;
			}
		}
		
		override public function setStatus(status:String):void
		{
			if(box != null)
			{
				box.status = status;
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