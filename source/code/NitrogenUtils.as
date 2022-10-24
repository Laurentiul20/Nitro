package code {

  import flash.display.*;
  import flash.text.*;
	
  public class NitrogenUtils {

		static function setupTextFieldC0(tf:TextField, x:Number, w:Number,
																		 fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.width = w;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
		}

		public static function setupTextFieldC1(container:Sprite, tf:TextField,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):void {
			setupTextFieldC0(tf, x, w, fontSize, bold);
			tf.y = y;
			tf.height = h;
			container.addChild(tf);
		}
		
		public static function setupTextFieldC2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			setupTextFieldC1(container, tf, x, y, w, h, fontSize, bold);
			return tf;
		}
		
		public static function setupTextFieldC3(container:Sprite, name:String,
																						x:Number, yTop:Number, w:Number, hFrame:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			setupTextFieldC0(tf, x, w, fontSize, bold);
			container.addChild(tf);
			tf.y = yTop + (hFrame - tf.getBounds(container).height) / 2;
			return tf;
		}
		
		public static function setupTextFieldC4(container:Sprite, tf:TextField,
																						x:Number, y:Number, w:Number, h:Number,
																						color:uint,
																						fontSize:Object, bold:Object=false):void {
			setupTextFieldC1(container, tf, x, y, w, h, fontSize, bold);
			tf.textColor = color;
		}
		
		public static function setupTextFieldR1(container:Sprite, tf:TextField,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):void {
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.RIGHT;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			container.addChild(tf);
		}
		
		public static function setupTextFieldR2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			setupTextFieldR1(container, tf, x, y, w, h, fontSize, bold);
			return tf;
		}
		
		// this function is specifically for costs bar
		public static function setupTextFieldL1(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object):TextField {
			var myFont:Font = new ArialBoldFont();
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.font = myFont.fontName;
			format.size = fontSize;
			format.bold = true;
			
			var tf:TextField = new TextField();
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.defaultTextFormat = format;
			tf.setTextFormat(format);
			tf.rotation = -90;
			container.addChild(tf);
			return tf;
		}
		
		public static function setupTextFieldL2(container:Sprite, name:String,
																						x:Number, y:Number, w:Number, h:Number,
																						fontSize:Object, bold:Object=false):TextField {
			var tf:TextField = new TextField();
			tf.text = name;
			tf.x = x;
			tf.y = y;
			tf.width = w;
			tf.height = h;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.LEFT;
			format.size = fontSize;
			format.bold = bold;
			format.font = "Arial";
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
			container.addChild(tf);
			return tf;
		}
	}
}
