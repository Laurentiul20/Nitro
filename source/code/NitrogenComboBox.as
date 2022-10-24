package code {
	
	import fl.controls.ComboBox;
	import flash.text.TextFormat;

  public class NitrogenComboBox extends ComboBox {
		
		public function NitrogenComboBox() {
			super();

			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			
			textField.setStyle("textFormat", tf);
			dropdown.setRendererStyle("textFormat", tf);
		}
	}
}