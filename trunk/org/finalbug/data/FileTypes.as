/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	import mx.controls.Image;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.data.DataModel;
	import org.finalbug.data.FileType;
	import org.finalbug.data.FileTypes;
	import org.finalbug.data.Icons;
	
	/**
	 * FileType
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FileTypes extends DataModel
	{
		//***************************************
		// SINGLETON
		//***************************************
		
		private static var ft:FileTypes;
		private static var instanceable:Boolean = false;
		
		public static function get instance():FileTypes
		{
			if(ft == null)
			{
				instanceable = true;
				ft = new FileTypes();
				instanceable = false;
			}
			return ft;
		}
		
		//***************************************
		// DEFINE
		//***************************************
		
		private var list:Object = new Object();
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FileTypes()
		{
			super();
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
			else
			{
				registerDefaultTypes();
			}
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		//***************************************
		// PUBLIC
		//***************************************
		
		public function registerType(type:FileType):void
		{
			list[type.ext] = type;
		}
		
		public function removeType(type:FileType):void
		{
			var ext:String = type.ext;
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
		
		public function getFileType(ext:String):FileType
		{
			ext = ext.toLowerCase();
			if(list[ext] != null)
			{
				return list[ext];
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
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function registerDefaultTypes():void
		{
			this.registerType(new FileType("txt", "", Icons.instance.docIcon));
			this.registerType(new FileType("doc", "", Icons.instance.docIcon));
			this.registerType(new FileType("png", "", Icons.instance.imgIcon));
			this.registerType(new FileType("jpg", "", Icons.instance.imgIcon));
			this.registerType(new FileType("gif", "", Icons.instance.imgIcon));
			this.registerType(new FileType("mov", "", Icons.instance.videoIcon));
			this.registerType(new FileType("avi", "", Icons.instance.videoIcon));
			this.registerType(new FileType("mpg", "", Icons.instance.videoIcon));
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}