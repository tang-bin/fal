// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.style
{
	import ftk.events.DataEvent;

	import flash.text.TextFormat;

	import ftk.utils.DataUtil;

	/**
	 * UIStyle
	 *
	 * @author Tang Bin
	 * @since 2011-3-2
	 */
	public class UIStyle extends Style
	{
		public function UIStyle()
		{
			_normalFS = new FillStyle();
			_selectedFS = new FillStyle();
			_overFS = new FillStyle();
			_selectedOverFS = new FillStyle();
			_downFS = new FillStyle();
			_selectedDownFS = new FillStyle();
			_disabledFS = new FillStyle();
			_selectedDisabledFS = new FillStyle();
			//
			allFillStyles.push(_normalFS, _selectedFS, _overFS, _selectedOverFS, _downFS, _selectedDownFS, _disabledFS, _selectedDisabledFS);
			//
			_normalTF = new TextFormat();
			_selectedTF = new TextFormat();
			_overTF = new TextFormat();
			_selectedOverTF = new TextFormat();
			_downTF = new TextFormat();
			_selectedDownTF = new TextFormat();
			_disabledTF = new TextFormat();
			_selectedDisabledTF = new TextFormat();
			//
			allTextFormat.push(_normalTF, _selectedTF, _overTF, _selectedOverTF, _downTF, _selectedDownTF, _disabledTF, _selectedDisabledTF);
		}

		public var allFillStyles:Array = new Array();

		public var allTextFormat:Array = new Array();

		private static var _defaultButtonStyle:ButtonStyle;

		private static var _defaultCheckBoxStyle:CheckBoxStyle;

		private static var _defaultRadioButtonStyle:RadioButtonStyle;

		private static var _defaultScrollBarStyle:ScrollBarStyle;

		private static var _defaultScrollBoxStyle:ScrollBoxStyle;

		private static var _defaultTextInputStyle:TextInputStyle;

		private var _normalFS:FillStyle;

		private var _selectedFS:FillStyle;

		private var _overFS:FillStyle;

		private var _selectedOverFS:FillStyle;

		private var _downFS:FillStyle;

		private var _selectedDownFS:FillStyle;

		private var _disabledFS:FillStyle;

		private var _selectedDisabledFS:FillStyle;

		private var _normalTF:TextFormat;

		private var _selectedTF:TextFormat;

		private var _overTF:TextFormat;

		private var _selectedOverTF:TextFormat;

		private var _downTF:TextFormat;

		private var _selectedDownTF:TextFormat;

		private var _disabledTF:TextFormat;

		private var _selectedDisabledTF:TextFormat;

		public static function get defaultButtonStyle():ButtonStyle
		{
			if (_defaultButtonStyle == null)
			{
				_defaultButtonStyle = new ButtonStyle();
			}
			return _defaultButtonStyle;
		}

		public static function get defaultCheckBoxStyle():CheckBoxStyle
		{
			if (_defaultCheckBoxStyle == null)
			{
				_defaultCheckBoxStyle = new CheckBoxStyle();
			}
			return _defaultCheckBoxStyle;
		}

		public static function get defaultRadioButtonStyle():RadioButtonStyle
		{
			if (_defaultRadioButtonStyle == null)
			{
				_defaultRadioButtonStyle = new RadioButtonStyle();
			}
			return _defaultRadioButtonStyle;
		}

		public static function get defaultScrollBarStyle():ScrollBarStyle
		{
			if (_defaultScrollBarStyle == null)
			{
				_defaultScrollBarStyle = new ScrollBarStyle();
			}
			return _defaultScrollBarStyle;
		}

		public static function get defaultScrollBoxStyle():ScrollBoxStyle
		{
			if (_defaultScrollBoxStyle == null)
			{
				_defaultScrollBoxStyle = new ScrollBoxStyle();
			}
			return _defaultScrollBoxStyle;
		}

		public static function get defaultTextInputStyle():TextInputStyle
		{
			if (_defaultTextInputStyle == null)
			{
				_defaultTextInputStyle = new TextInputStyle;
			}
			return _defaultTextInputStyle;
		}

		public function get normalFillStyle():FillStyle
		{
			return _normalFS;
		}

		public function get selectedFillStyle():FillStyle
		{
			return _selectedFS;
		}

		public function get overFillStyle():FillStyle
		{
			return _overFS;
		}

		public function get selectedOverFillStyle():FillStyle
		{
			return _selectedOverFS;
		}

		public function get downFillStyle():FillStyle
		{
			return _downFS;
		}

		public function get selectedDownFillStyle():FillStyle
		{
			return _selectedDownFS;
		}

		public function get disabledFillStyle():FillStyle
		{
			return _disabledFS;
		}

		public function get selectedDisabledFillStyle():FillStyle
		{
			return _selectedDisabledFS;
		}

		public function get normalTextFormat():TextFormat
		{
			return _normalTF;
		}

		public function get selectedTextFormat():TextFormat
		{
			return _selectedTF;
		}

		public function get overTextFormat():TextFormat
		{
			return _overTF;
		}

		public function get selectedOverTextFormat():TextFormat
		{
			return _selectedOverTF;
		}

		public function get downTextFormat():TextFormat
		{
			return _downTF;
		}

		public function get selectedDownTextFormat():TextFormat
		{
			return _selectedDownTF;
		}

		public function get disabledTextFormat():TextFormat
		{
			return _disabledTF;
		}

		public function get selectedDisabledTextFormat():TextFormat
		{
			return _selectedDisabledTF;
		}

		public function setStyleToAll(property:String, value:*):void
		{
			for (var i:uint = allFillStyles.length ; --i >= 0 ; )
			{
				var fs:FillStyle = allFillStyles[i] as FillStyle;
				if (fs != null && fs.hasOwnProperty(property))
				{
					fs[property] = value;
				}
			}
		}

		public function setTextFormatToAll(property:String, value:*):void
		{
			for (var i:uint = allTextFormat.length ; --i >= 0 ; )
			{
				var tf:TextFormat = allTextFormat[i] as TextFormat;
				if (tf != null && tf.hasOwnProperty(property))
				{
					tf[property] = value;
				}
			}
		}

		public function applyStyleToAll(style:FillStyle):void
		{
			for (var i:uint = allFillStyles.length ; --i >= 0 ; )
			{
				var fs:FillStyle = allFillStyles[i] as FillStyle;
				if (fs != null)
				{
					fs.copy(style);
				}
			}
		}

		public function applyTextFormatToAll(textFormat:TextFormat):void
		{
			for (var i:uint = allTextFormat.length ; --i >= 0 ; )
			{
				var tf:TextFormat = allTextFormat[i] as TextFormat;
				if (tf != null)
				{
					DataUtil.textFormatClone(textFormat, tf);
				}
			}
		}

		protected function dispatchStyleChanged():void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_STYLE);
			this.dispatchEvent(ee);
		}
	}
}
