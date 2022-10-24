package code {
	
	import fl.core.UIComponent;
	import flash.text.*;
	import flash.display.SimpleButton;
	import flash.errors.IllegalOperationError;
	
	public class NitrogenSliderThumb extends UIComponent {
		
		protected var tfValue:TextField;
		protected var button:SimpleButton;
		
		public function NitrogenSliderThumb(val:Number) {
			setupButton();
			setupValueField(val);
    }
		
		public function setValue(val:Number):void {
			if (tfValue)
				tfValue.text = String(val);
		}
		
		protected function setupButton() {
			throw new IllegalOperationError("The NitrogenSliderThumb class does not implement this method.");
		}
		
		protected function setupValueField(val:Number) {
			throw new IllegalOperationError("The NitrogenSliderThumb class does not implement this method.");
		}
		
		protected function setupValueTF(val:Number, x:Number, y:Number) {
			tfValue = new TextField();
			tfValue.mouseEnabled = false;
			setValue(val);
			NitrogenUtils.setupTextFieldC4(this, tfValue, x, y, 16, 18,
																		 NitrogenConsts.WHITE_COLOR,
																		 14, true);
		}
	}
	
}
