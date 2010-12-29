/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.ui.skin
{
	import flash.utils.Dictionary;
	
	import org.finalbug.data.DataModel;
	import org.finalbug.errors.DataError;
	
	
	/**
	 * UISkinModel
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class UISkinModel extends DataModel
	{
		//***************************************
		// SINGLETON
		//***************************************/
		
		private static var instanceable:Boolean = false;
		private static var sm:UISkinModel;
		
		public static function get instance():UISkinModel
		{
			if(sm == null)
			{
				instanceable = true;
				sm = new UISkinModel();
				instanceable = false;
			}
			return sm;
		}
		
		//***************************************
		// DEFINE
		//***************************************/
		
		private var UISkins:Dictionary = new Dictionary();
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		public function get buttonSkin():ButtonSkin
		{
			if(UISkins["buttonSkin"] == null) UISkins["buttonSkin"] = new ButtonSkin();
			return UISkins["buttonSkin"];
		}
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function UISkinModel()
		{
			super();
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
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