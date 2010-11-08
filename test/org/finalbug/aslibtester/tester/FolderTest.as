/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.aslibtester.tester
{
	import org.finalbug.data.DirectoryFileData;
	import org.finalbug.data.Icons;
	import org.finalbug.framework.layout.Container;
	import org.finalbug.ui.control.Icon;
	import org.finalbug.ui.control.Label;
	import org.finalbug.ui.gadgets.folder.FolderGridBox;
	import org.finalbug.ui.gadgets.folder.FolderItem;
	
	
	/**
	 * FolderTest
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class FolderTest extends Container
	{
		//***************************************
		// DEFINE
		//***************************************/
		
		private var fb:FolderGridBox;
		
		//***************************************
		// GETTER and SETTER
		//***************************************/
		
		//***************************************
		// Constructor.
		//***************************************/
		
		public function FolderTest()
		{
			super();
			//
			var container:Container = new Container();
			container.width = container.height = 400;
			this.addChild(container);
			//
			fb = new FolderGridBox();
			container.addChild(fb);
			//
			var fi:FolderItem = new FolderItem(new DirectoryFileData());
			fi.width = fi.height = 64;
			this.addAll(fi);
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