// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.data
{
	import flash.utils.Dictionary;
	import ftk.errors.DataError;


	/**
	 * FileTypeModel use singleton model, defines all file types used in this library.
	 * You can also regiester your file type into this model and use it in your projects.
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class FileTypeModel extends DataModel
	{

		/******************* SINGLETON **************************************************/
		private static var ft:FileTypeModel;

		private static var instanceable:Boolean = false;

		/**
		 * 
		 * @return 
		 */
		public static function get instance():FileTypeModel
		{
			if (ft == null)
			{
				instanceable = true;
				ft = new FileTypeModel();
				instanceable = false;
			}
			return ft;
		}

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		private var list:Dictionary = new Dictionary();

		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 * @throws DataError
		 */
		public function FileTypeModel()
		{
			super();
			if (!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
			else
			{
				registerDefaultTypes();
			}
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * Register an new file type.
		 * 
		 * @param type
		 */
		public function registerType(type:FileType):void
		{
			list[type.ext] = type;
		}

		/**
		 * 
		 * @param type
		 * @throws DataError
		 */
		public function removeType(type:FileType):void
		{
			var ext:String = type.ext;
			if (list[ext] != null)
			{
				list[ext] = null;
				delete list[ext];
			}
			else
			{
				throw new DataError(DataError.CANNOT_REMOVE_NONEXISTENT_DATA);
			}
		}

		/**
		 * 
		 * @param ext
		 * @return 
		 * @throws DataError
		 */
		public function getFileType(ext:String):FileType
		{
			ext = ext.toLowerCase();
			if (list[ext] != null)
			{
				return list[ext];
			}
			else
			{
				throw new DataError(DataError.DATA_NULL);
			}
		}

		/**
		 * 
		 * @param ext
		 * @return 
		 */
		public function registered(ext:String):Boolean
		{
			return list[ext.toLowerCase()] != null;
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function registerDefaultTypes():void
		{
			this.registerType(new FileType("txt", "", IconModel.instance.docIcon));
			this.registerType(new FileType("doc", "", IconModel.instance.docIcon));
			this.registerType(new FileType("png", "", IconModel.instance.imgIcon));
			this.registerType(new FileType("jpg", "", IconModel.instance.imgIcon));
			this.registerType(new FileType("gif", "", IconModel.instance.imgIcon));
			this.registerType(new FileType("mov", "", IconModel.instance.videoIcon));
			this.registerType(new FileType("avi", "", IconModel.instance.videoIcon));
			this.registerType(new FileType("mpg", "", IconModel.instance.videoIcon));
		}
		/******************* PRIVATE ***************************************************/
	}
}