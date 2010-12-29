/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DataModel;
	
	
	/**
	 * UISkinBase
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class UISkinBase extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		protected var skinList:Dictionary = new Dictionary();
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function UISkinBase()
		{
			super();
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************/
		
		//***************************************
		// PUBLIC
		//***************************************/
		
		public function setSkin(skin:SkinElement):void
		{
			if(skin != null)
			{
				setStatusSkinByList(skin, skinList);
			}
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		protected function setStatusSkinByList(skinElement:SkinElement, list:Dictionary):void
		{
			for each(var skinData:SkinData in list)
			{
				if(skinData != null)
				{
					skinElement.setSkin(skinData);
				}
			}
		}
		
		//***************************************
		// PRIVATE
		//***************************************/
		
		//***************************************
		// HANDLER
		//***************************************/
	}
}