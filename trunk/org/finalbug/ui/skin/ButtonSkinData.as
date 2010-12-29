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
	 * ButtonSkin
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class ButtonSkinData extends UISkinDataBase
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		[Embed(source="/resources/skins/btnSkin_normal.png")]
		private var normalSkinCls:Class
		
		[Embed(source="/resources/skins/btnSkin_over.png")]
		private var overSkinCls:Class
		
		[Embed(source="/resources/skins/btnSkin_down.png")]
		private var downSkinCls:Class
		
		[Embed(source="/resources/skins/btnSkin_disable.png")]
		private var disableSkinCls:Class
		
		// skin elements
		private var bgElement:SkinElement;
		private var label:Label;
		
		// skin datas.
		private var bgSkins:Dictionary;
		private var txtFormats:Dictionary;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function ButtonSkinData()
		{
			super();
			// skin
			bgSkins = new Dictionary();
			bgSkins[Status.NORMAL] = new SkinElementData(Status.NORMAL, SkinElementData.BITMAP_TYPE, new normalSkinCls(), true);
			bgSkins[Status.MOUSE_OVER] = new SkinElementData(Status.MOUSE_OVER, SkinElementData.BITMAP_TYPE, new overSkinCls());
			bgSkins[Status.MOUSE_DOWN] = new SkinElementData(Status.MOUSE_DOWN, SkinElementData.BITMAP_TYPE, new downSkinCls());
			bgSkins[Status.DISABLE] = new SkinElementData(Status.DISABLE, SkinElementData.BITMAP_TYPE, new disableSkinCls());
			// text format
			txtFormats = new Dictionary();
			txtFormats[Status.NORMAL] = new TextFormat("Arial", 12, 0xFFFFFF, true);
			txtFormats[Status.MOUSE_OVER] = new TextFormat("Arial", 12, 0xFFFFFF, true);
			txtFormats[Status.MOUSE_DOWN] = new TextFormat("Arial", 12, 0xFFFFFF, true);
			txtFormats[Status.DISABLE] = new TextFormat("Arial", 12, 0xFFFFFF, true);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		override public function setSkin(...args):void
		{
			bgElement = args[0] as SkinElement;
			if(bgElement != null)
			{
				setStatusSkinByList(bgElement, bgSkins);
			}
			label = args[1] as Label;
			if(label != null)
			{
				label.textFormat = txtFormats[Status.NORMAL];
			}
		}
		
		override public function setStatus(status:String):void
		{
			if(bgElement != null)
			{
				bgElement.status = status;
			}
			if(label != null)
			{
				label.textFormat = txtFormats[status];
			}
		}
		
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