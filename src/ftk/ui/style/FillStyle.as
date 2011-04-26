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
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	import ftk.utils.DataUtil;
	import ftk.utils.MathUtil;



	/**
	 * FillStyle
	 *  
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class FillStyle extends Style
	{

		/******************* OVERRIDE **************************************************/
		/******************* DEFINE ****************************************************/
		private var bindList:Dictionary = new Dictionary();

		private var _borderSize:Number = 1;

		private var _borderColor:Number = 0x999999;

		private var _borderAlpha:Number = 0;

		private var _bgColor:Number = 0xFFFFFF;

		private var _bgAlpha:Number = 0;

		private var _topLeftRadius:Number = 0;

		private var _topRightRadius:Number = 0;

		private var _bottomLeftRadius:Number = 0;

		private var _bottomRightRadius:Number = 0;

		private var _radius:Number = 0;

		private var uniformRadius:Boolean = true;

		private var _bgColors:Array = [0x333, 0xFFF];

		private var _bgAlphas:Array = [1, 1];

		private var _bgRotation:Number = 0;

		private var _bgRatios:Array = [0, 0xFF];

		/**
		 * 
		 * @default 
		 */
		public var useGradient:Boolean = false;

		private var _glowColor:uint = 0;

		private var _glowAlpha:Number = 0;

		private var _glowBlur:Number = 2;

		private var _glowStrength:int = 3;

		private var _innerGlow:Boolean = false;

		private var _shadowColor:uint = 0;

		private var _shadowAlpha:Number = 0;

		private var _shadowDistance:Number = 3;

		private var _shadowStrength:int = 3;

		private var _shadowBlur:Number = 3;

		/******************* GETTER and SETTER *****************************************/
		/**
		 * 
		 * @return 
		 */
		public function get borderSize():Number
		{
			return _borderSize;
		}

		/**
		 * 
		 * @param value
		 */
		public function set borderSize(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 20);
			if (_borderSize != value)
			{
				_borderSize = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get borderColor():Number
		{
			return _borderColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set borderColor(value:Number):void
		{
			if (value != _borderColor)
			{
				_borderColor = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set borderAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			if (value != _borderAlpha)
			{
				_borderAlpha = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgColor():Number
		{
			return _bgColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgColor(value:Number):void
		{
			if (value != _bgColor)
			{
				_bgColor = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgAlpha():Number
		{
			return _bgAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			if (_bgAlpha != value)
			{
				_bgAlpha = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get radius():Number
		{
			return _radius;
		}

		/**
		 * 
		 * @param value
		 */
		public function set radius(value:Number):void
		{
			if (value >= 0)
			{
				this._radius = value;
				this.uniformRadius = true;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get topLeftRadius():Number
		{
			if (this.uniformRadius) return radius;
			else return _topLeftRadius;
		}

		/**
		 * 
		 * @param value
		 */
		public function set topLeftRadius(value:Number):void
		{
			if (value >= 0)
			{
				_topLeftRadius = value;
				this.uniformRadius = false;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get topRightRadius():Number
		{
			if (this.uniformRadius) return radius;
			else return _topRightRadius;
		}

		/**
		 * 
		 * @param value
		 */
		public function set topRightRadius(value:Number):void
		{
			if (value >= 0)
			{
				_topRightRadius = value;
				this.uniformRadius = false;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bottomLeftRadius():Number
		{
			if (this.uniformRadius) return radius;
			else return _bottomLeftRadius;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bottomLeftRadius(value:Number):void
		{
			if (value >= 0)
			{
				_bottomLeftRadius = value;
				this.uniformRadius = false;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bottomRightRadius():Number
		{
			if (this.uniformRadius) return radius;
			else return _bottomRightRadius;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bottomRightRadius(value:Number):void
		{
			if (value >= 0)
			{
				_bottomRightRadius = value;
				this.uniformRadius = false;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgColors():Array
		{
			return _bgColors;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgColors(value:Array):void
		{
			if (_bgColors != value)
			{
				_bgColors = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgAlphas():Array
		{
			return _bgAlphas;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgAlphas(value:Array):void
		{
			if (value != _bgAlphas)
			{
				_bgAlphas = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgRotation():Number
		{
			return _bgRotation;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgRotation(value:Number):void
		{
			if (value != _bgRotation)
			{
				_bgRotation = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get glowColor():Number
		{
			return _glowColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set glowColor(value:Number):void
		{
			if (value != _glowColor)
			{
				_glowColor = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get glowAlpha():Number
		{
			return _glowAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set glowAlpha(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 1);
			if (value != _glowAlpha)
			{
				_glowAlpha = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get glowBlur():Number
		{
			return _glowBlur;
		}

		/**
		 * 
		 * @param value
		 */
		public function set glowBlur(value:Number):void
		{
			value = MathUtil.getNumArea(value, 0, 100);
			if (value != _glowBlur)
			{
				_glowBlur = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get glowStrength():int
		{
			return _glowStrength;
		}

		/**
		 * 
		 * @param value
		 */
		public function set glowStrength(value:int):void
		{
			value = MathUtil.getNumArea(value, 1, 3);
			if (value != _glowStrength)
			{
				_glowStrength = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get bgRatios():Array
		{
			return _bgRatios;
		}

		/**
		 * 
		 * @param value
		 */
		public function set bgRatios(value:Array):void
		{
			if (value != _bgRatios)
			{
				_bgRatios = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get shadowColor():uint
		{
			return _shadowColor;
		}

		/**
		 * 
		 * @param value
		 */
		public function set shadowColor(value:uint):void
		{
			if (value != _shadowColor)
			{
				_shadowColor = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get shadowAlpha():Number
		{
			return _shadowAlpha;
		}

		/**
		 * 
		 * @param value
		 */
		public function set shadowAlpha(value:Number):void
		{
			if (value != _shadowAlpha)
			{
				_shadowAlpha = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get shadowDistance():Number
		{
			return _shadowDistance;
		}

		/**
		 * 
		 * @param value
		 */
		public function set shadowDistance(value:Number):void
		{
			if (value != _shadowDistance)
			{
				_shadowDistance = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get shadowStrength():Number
		{
			return _shadowStrength;
		}

		/**
		 * 
		 * @param value
		 */
		public function set shadowStrength(value:Number):void
		{
			if (value != _shadowStrength)
			{
				_shadowStrength = value;
				refreshBind();
			}
		}

		/**
		 * 
		 * @return 
		 */
		public function get shadowBlur():Number
		{
			return _shadowBlur;
		}

		public function set shadowBlur(value:Number):void
		{
			if (value != _shadowBlur)
			{
				_shadowBlur = value;
				refreshBind();
			}
		}

		/**
		 * 
		 */
		public function get innerGlow():Boolean
		{
			return _innerGlow;
		}

		public function set innerGlow(value:Boolean):void
		{
			if (value != _innerGlow)
			{
				_innerGlow = value;
				refreshBind();
			}
		}

		/******************* CONSTRUCTOR ***********************************************/
		/**
		 * 
		 */
		public function FillStyle(style:FillStyle = null)
		{
			super();
			if (style != null)
			{
				this.copy(style);
			}
		}

		/******************* PUBLIC ****************************************************/
		/**
		 * 
		 * @return 
		 */
		public function createGlowFilter():GlowFilter
		{
			var gf:GlowFilter = new GlowFilter(this._glowColor, this._glowAlpha, this._glowBlur, this._glowBlur, this._glowStrength, 3);
			return gf;
		}

		/**
		 * 
		 * @return 
		 */
		public function clone():FillStyle
		{
			var style:FillStyle = new FillStyle();
			style.filters = this.filters;
			//
			style.borderSize = this.borderSize;
			style.borderAlpha = this.borderAlpha;
			style.borderColor = this.borderColor;
			style.bgAlpha = this.bgAlpha;
			style.bgColor = this.bgColor;
			//
			if (this.uniformRadius)
			{
				style.radius = this.radius;
			}
			else
			{
				style.radius = this.radius;
				style.topLeftRadius = this.topLeftRadius;
				style.topRightRadius = this.topRightRadius;
				style.bottomLeftRadius = this.bottomLeftRadius;
				style.bottomRightRadius = this.bottomRightRadius;
			}
			//
			style.bgColors = DataUtil.arrayClone(this.bgColors);
			style.bgAlphas = DataUtil.arrayClone(this.bgAlphas);
			style.bgRatios = DataUtil.arrayClone(this.bgRatios);
			style.bgRotation = this.bgRotation;
			style.useGradient = this.useGradient;
			//
			style.glowColor = this.glowColor;
			style.glowAlpha = this.glowAlpha;
			style.glowBlur = this.glowBlur;
			style.glowStrength = this.glowStrength;
			style.innerGlow = this.innerGlow;
			//
			style.shadowColor = this.shadowColor;
			style.shadowAlpha = this.shadowAlpha;
			style.shadowDistance = this.shadowDistance;
			style.shadowStrength = this.shadowStrength;
			style.shadowBlur = this.shadowBlur;
			//
			return style;
		}

		public function copy(style:FillStyle):void
		{
			this.filters = style.filters;
			//
			this._borderSize = style.borderSize;
			this._borderAlpha = style.borderAlpha;
			this._borderColor = style.borderColor;
			this._bgAlpha = style.bgAlpha;
			this._bgColor = style.bgColor;
			//
			if (style.uniformRadius)
			{
				this._radius = style.radius;
			}
			else
			{
				this._radius = style.radius;
				this._topLeftRadius = style.topLeftRadius;
				this._topRightRadius = style.topRightRadius;
				this._bottomLeftRadius = style.bottomLeftRadius;
				this._bottomRightRadius = style.bottomRightRadius;
			}
			//
			this._bgColors = DataUtil.arrayClone(style.bgColors);
			this._bgAlphas = DataUtil.arrayClone(style.bgAlphas);
			this._bgRatios = DataUtil.arrayClone(style.bgRatios);
			this._bgRotation = style.bgRotation;
			this.useGradient = style.useGradient;
			//
			this._glowColor = style.glowColor;
			this._glowAlpha = style.glowAlpha;
			this._glowBlur = style.glowBlur;
			this._glowStrength = style.glowStrength;
			this._innerGlow = style.innerGlow;
			//
			this._shadowColor = style.shadowColor;
			this._shadowAlpha = style.shadowAlpha;
			this._shadowDistance = style.shadowDistance;
			this._shadowStrength = style.shadowStrength;
			this._shadowBlur = style.shadowBlur;
			//
			this.refreshBind();
		}

		/**
		 * Fill a display object with current style.
		 * 
		 * @param target The display object which will be filled in.
		 * @param width Fill width
		 * @param height Fill Height
		 */
		public function fill(target:DisplayObject, width:Number, height:Number, clear:Boolean = true, binding:Boolean = false):void
		{
			var g:Graphics = target["graphics"] as Graphics;
			if (g != null)
			{
				// save binding data.
				if (binding)
				{
					if (bindList[target] == null)
					{
						bindList[target] = new BindData(target, width, height, clear);
					}
					else
					{
						var oldData:BindData = bindList[target] as BindData;
						oldData.clear = clear;
						oldData.width = width;
						oldData.height = height;
					}
				}
				else if (!binding && bindList[target] != null)
				{
					bindList[target] = null;
					delete bindList[target];
				}
				// do draw.
				if (clear)
				{
					g.clear();
				}
				//
				if (width > 0 && height > 0)
				{
					// set border style
					g.lineStyle(borderSize, borderColor, borderAlpha);
					// set fill style
					if (useGradient)
					{
						var fillType:String = GradientType.LINEAR;
						var matr:Matrix = new Matrix();
						matr.createGradientBox(width, height, Math.PI * bgRotation / 180, 0, 0);
						g.beginGradientFill(fillType, bgColors, bgAlphas, bgRatios, matr);
					}
					else
					{
						g.beginFill(bgColor, bgAlpha);
					}
					//
					g.drawRoundRectComplex(0, 0, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
					g.endFill();
					//
					// set filter
					var fs:Array = new Array();
					if (glowAlpha > 0 && glowBlur > 0)
					{
						var gf:GlowFilter = new GlowFilter(glowColor, glowAlpha, glowBlur, glowBlur, glowStrength, 3, _innerGlow);
						fs.push(gf);
					}
					if (shadowAlpha > 0 && shadowBlur > 0)
					{
						var sf:DropShadowFilter = new DropShadowFilter(shadowDistance, 45, shadowColor, shadowAlpha, shadowBlur, shadowBlur, shadowStrength);
						fs.push(sf);
					}
					target.filters = fs.length == 0 ? null : fs;
				}
			}
		}

		public function removeBind(target:DisplayObject):void
		{
			if (bindList[target])
			{
				bindList[target] = null;
				delete bindList[target];
			}
		}

		/******************* PROTECTED *************************************************/
		/******************* PRIVATE ***************************************************/
		private function refreshBind():void
		{
			for each (var data:BindData in bindList)
			{
				this.fill(data.target, data.width, data.height, data.clear, true);
			}
		}
		/******************* PRIVATE ***************************************************/
	}
}
import flash.display.DisplayObject;

class BindData
{

	public var target:DisplayObject;

	public var width:Number;

	public var height:Number;

	public var clear:Boolean;

	public function BindData(target:DisplayObject, width:Number, height:Number, clear:Boolean)
	{
		this.target = target;
		this.width = width;
		this.height = height;
		this.clear = clear;
	}
}