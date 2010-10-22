/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.data
{
	import mx.controls.Image;
	
	import org.finalbug.errors.DataError;
	
	/**
	 * FileType
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FileType extends DataModel
	{
		//***************************************
		// SINGLETON
		//***************************************/
		
		private static var ft:FileType;
		private static var instanceable:Boolean = false;
		
		public static function get instance():FileType
		{
			if(ft == null)
			{
				instanceable = true;
				ft = new FileType();
				instanceable = false;
				//
				
			}
			return ft;
		}
		
		//***************************************
		// DEFINE
		//***************************************/
		
		private var list:Object = new Object();
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function FileType()
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
		
		public function registerType(ext:String, des:String, icon:Image = null):void
		{
			ext = ext.toLowerCase();
			list[ext] = {des:des, icon:icon};
		}
		
		public function removeType(ext:String):void
		{
			ext = ext.toLowerCase();
			if(list[ext] != null)
			{
				list[ext] = null;
				delete list[ext];
			}
			else
			{
				throw new DataError(DataError.CANNOT_REMOVE_NONEXISTENT_DATA);
			}
		}
		
		public function getDescription(ext:String):String
		{
			ext = ext.toLowerCase();
			if(list[ext] != null)
			{
				return list[ext]["des"];
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		public function getIcon(ext:String):Image
		{
			ext = ext.toLowerCase();
			if(list[ext] != null)
			{
				return list[ext]["icon"];
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}
		
		public function registered(ext:String):Boolean
		{
			return list[ext.toLowerCase()] != null;
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