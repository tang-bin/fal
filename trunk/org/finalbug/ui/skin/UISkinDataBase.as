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
	public class UISkinDataBase extends DataModel
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function UISkinDataBase()
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
		
		public function setSkin(...args):void
		{
			// this method should be overrided in sub classes.
		}
		
		public function setStatus(status:String):void
		{
			// this method should be overrided in sub classes.
		}
		
		//***************************************
		// PROTECTED
		//***************************************/
		
		protected function setStatusSkinByList(skinElement:SkinElement, list:Dictionary):void
		{
			for each(var skinData:SkinElementData in list)
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