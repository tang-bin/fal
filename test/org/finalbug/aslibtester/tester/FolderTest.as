/******************************************
 * Tang Bin
 *****************************************/
package org.finalbug.aslibtester.tester
{
	import org.finalbug.data.DirectoryData;
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
		//***************************************
		
		private var fb:FolderGridBox;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function FolderTest()
		{
			super();
			//
			var container:Container = new Container();
			container.width = container.height = 400;
			this.addChild(container);
			//
			var dd:DirectoryData = new DirectoryData();
			for(var i:uint = 0 ; i < 100 ; i++)
			{
				var fd:DirectoryFileData = new DirectoryFileData();
				fd.name += i.toString();
				dd.addFile(fd);
			}
			//
			fb = new FolderGridBox(dd);
			container.addChild(fb);
		}
		
		//***************************************
		// OVERRIDE METHODS
		// Whit out getter, setter and handler
		// include public, protected and private.
		//***************************************
		
		//***************************************
		// PUBLIC
		//***************************************
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		//***************************************
		// HANDLER
		//***************************************
	}
}