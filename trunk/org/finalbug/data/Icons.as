/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.data
{
	import flash.display.Bitmap;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.Icon;
	import org.finalbug.data.DataModel;
	import org.finalbug.data.Icons;
	
	/**
	 * Icons
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class Icons extends DataModel
	{
		//***************************************
		// SINGTON
		//***************************************
		
		private static var icons:Icons;
		private static var instanceable:Boolean = false;
		
		public static function get instance():Icons
		{
			if(icons == null)
			{
				instanceable = true;
				icons = new Icons();
				instanceable = false;
			}
			return icons;
		}
		
		//***************************************
		// DEFINE
		//***************************************
		
		[Embed(source="/resources/icons/folder_128.png")] private var folder128:Class;
		[Embed(source="/resources/icons/folder_48.png")] private var folder48:Class;
		[Embed(source="/resources/icons/folder_32.png")] private var folder32:Class;
		[Embed(source="/resources/icons/folder_16.png")] private var folder16:Class;
		
		[Embed(source="/resources/icons/doc_128.png")] private var doc128:Class;
		[Embed(source="/resources/icons/doc_48.png")] private var doc48:Class;
		[Embed(source="/resources/icons/doc_32.png")] private var doc32:Class;
		[Embed(source="/resources/icons/doc_16.png")] private var doc16:Class;
		
		[Embed(source="/resources/icons/img_128.png")] private var img128:Class;
		[Embed(source="/resources/icons/img_48.png")] private var img48:Class;
		[Embed(source="/resources/icons/img_32.png")] private var img32:Class;
		[Embed(source="/resources/icons/img_16.png")] private var img16:Class;
		
		[Embed(source="/resources/icons/video_128.png")] private var video128:Class;
		[Embed(source="/resources/icons/video_48.png")] private var video48:Class;
		[Embed(source="/resources/icons/video_32.png")] private var video32:Class;
		[Embed(source="/resources/icons/video_16.png")] private var video16:Class;
		
		private var _folderIcon:Icon;
		private var _docIcon:Icon;
		private var _imgIcon:Icon;
		private var _videoIcon:Icon;
		private var _unknowIcon:Icon;
		
		//***************************************
		// GETTER and SETTER
		//***************************************
		
		public function get folderIcon():Icon
		{
			return _folderIcon.clone();
		}
		public function set folderIcon(value:Icon):void
		{
			if(_folderIcon != value)
			{
				_folderIcon = value;
				// TODO, dispatch event
			}
		}
		
		public function get docIcon():Icon
		{
			return _docIcon.clone();
		}
		public function set docIcon(value:Icon):void
		{
			if(_docIcon != value)
			{
				_docIcon = value;
				// TODO, dispatch event
			}
		}
		
		public function get imgIcon():Icon
		{
			return _imgIcon.clone();
		}
		public function set imgIcon(value:Icon):void
		{
			if(_imgIcon != value)
			{
				_imgIcon = value;
				// TODO, dispatch event
			}
		}
		
		public function get videoIcon():Icon
		{
			return _videoIcon.clone();
		}
		public function set videoIcon(value:Icon):void
		{
			if(_videoIcon != value)
			{
				_videoIcon = value;
				// TODO, dispatch event
			}
		}
		
		public function get unknowIcon():Icon
		{
			return _unknowIcon.clone();
		}
		public function set unknowIcon(value:Icon):void
		{
			if(_unknowIcon != value)
			{
				_unknowIcon = value;
				// TODO.
			}
		}
		
		//***************************************
		// Constructor.
		//***************************************
		
		public function Icons()
		{
			super();
			if(!instanceable)
			{
				throw new DataError(DataError.SINGLETON);
			}
			else
			{
				setDefaultIcons();
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
		
		//***************************************
		// PROTECTED
		//***************************************
		
		//***************************************
		// PRIVATE
		//***************************************
		
		private function setDefaultIcons():void
		{
			_folderIcon = new Icon();
			_folderIcon.addImage(new folder128(), Icon.ICON_128);
			_folderIcon.addImage(new folder48(), Icon.ICON_48);
			_folderIcon.addImage(new folder32(), Icon.ICON_32);
			_folderIcon.addImage(new folder16(), Icon.ICON_16);
			//
			_docIcon = new Icon();
			_docIcon.addImage(new doc128(), Icon.ICON_128);
			_docIcon.addImage(new doc48(), Icon.ICON_48);
			_docIcon.addImage(new doc32(), Icon.ICON_32);
			_docIcon.addImage(new doc16(), Icon.ICON_16);
			//
			_imgIcon = new Icon();
			_imgIcon.addImage(new img128(), Icon.ICON_128);
			_imgIcon.addImage(new img48(), Icon.ICON_48);
			_imgIcon.addImage(new img32(), Icon.ICON_32);
			_imgIcon.addImage(new img16(), Icon.ICON_16);
			//
			_videoIcon = new Icon();
			_videoIcon.addImage(new video128(), Icon.ICON_128);
			_videoIcon.addImage(new video48(), Icon.ICON_48);
			_videoIcon.addImage(new video32(), Icon.ICON_32);
			_videoIcon.addImage(new video16(), Icon.ICON_16);
		}
		
		//***************************************
		// HANDLER
		//***************************************
	}
}