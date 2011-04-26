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
package ftk.ui.style
{
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

		/******************* CONSTRUCTOR ***********************************************/
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
			_normalTF = new TextFormat();
			_selectedTF = new TextFormat();
			_overTF = new TextFormat();
			_selectedOverTF = new TextFormat();
			_downTF = new TextFormat();
			_selectedDownTF = new TextFormat();
			_disabledTF = new TextFormat();
			_selectedDisabledTF = new TextFormat();
		}

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
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

		/******************* GETTER and SETTER *****************************************/
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

		/******************* PUBLIC ****************************************************/
		public function applyStyleToAll(style:FillStyle):void
		{
			this.normalFillStyle.copy(style);
			this.overFillStyle.copy(style);
			this.downFillStyle.copy(style);
			this.disabledFillStyle.copy(style);
			this.selectedFillStyle.copy(style);
			this.selectedOverFillStyle.copy(style);
			this.selectedDownFillStyle.copy(style);
			this.selectedDisabledFillStyle.copy(style);
		}

		public function applyTextFormatToAll(textFormat:TextFormat):void
		{
			DataUtil.textFormatClone(textFormat, this.normalTextFormat);
			DataUtil.textFormatClone(textFormat, this.overTextFormat);
			DataUtil.textFormatClone(textFormat, this.downTextFormat);
			DataUtil.textFormatClone(textFormat, this.disabledTextFormat);
			DataUtil.textFormatClone(textFormat, this.selectedTextFormat);
			DataUtil.textFormatClone(textFormat, this.selectedOverTextFormat);
			DataUtil.textFormatClone(textFormat, this.selectedDownTextFormat);
			DataUtil.textFormatClone(textFormat, this.selectedDisabledTextFormat);
		}
		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		/******************* HANDLER ***************************************************/
	}
}
