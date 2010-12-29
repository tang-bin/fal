/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.Status;
	
	/**
	 * ButtonSkin
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class ButtonSkin extends UISkinBase
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
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function ButtonSkin()
		{
			super();
			skinList = new Dictionary();
			// skin
			skinList[Status.NORMAL] = new SkinData(Status.NORMAL, SkinData.BITMAP_TYPE, new normalSkinCls(), true);;
			skinList[Status.MOUSE_OVER] = new SkinData(Status.MOUSE_OVER, SkinData.BITMAP_TYPE, new overSkinCls(), true);;
			skinList[Status.MOUSE_DOWN] = new SkinData(Status.MOUSE_DOWN, SkinData.BITMAP_TYPE, new downSkinCls(), true);;
			skinList[Status.DISABLE] = new SkinData(Status.DISABLE, SkinData.BITMAP_TYPE, new disableSkinCls(), true);;
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
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