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
package ftk.ui.skin
{
	import flash.utils.Dictionary;
	import ftk.data.DataModel;


	/**
	 * UISkinBase
	 * 
	 * @author Tang Bin
	 * @since 2010.12
	 */
	public class UISkinDataAbstract extends DataModel
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		/******************* GETTER and SETTER *****************************************/
		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function UISkinDataAbstract()
		{
			super();
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @param args
		 */
		public function bindChildren(...args):void
		{
			// this method should be overrided in sub classes.
		}

		/**
		 * 
		 * @param status
		 */
		public function changeStatus(status:String):void
		{
			// this method should be overrided in sub classes.
		}

		/******************* PROTECTED *************************************************/
		/**
		 * 
		 * @param skin
		 * @param list
		 */
		protected function bindStatusesToSkin(skin:Skin, list:Dictionary):void
		{
			for each (var skinData:SkinData in list)
			{
				if (skinData != null)
				{
					skin.setSkinData(skinData);
				}
			}
		}
		/******************* PRIVATE ***************************************************/
		
		
		
		/******************* PRIVATE ***************************************************/
	}
}