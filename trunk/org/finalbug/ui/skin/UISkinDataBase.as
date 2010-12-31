//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
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
		//#######################################
		// DEFINE
		//#######################################
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 */
		public function UISkinDataBase()
		{
			super();
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param args
		 */
		public function setSkin(...args):void
		{
			// this method should be overrided in sub classes.
		}
		
		/**
		 * 
		 * @param status
		 */
		public function setStatus(status:String):void
		{
			// this method should be overrided in sub classes.
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 * 
		 * @param skinElement
		 * @param list
		 */
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
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}