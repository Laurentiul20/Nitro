package code {
	
	public class NitrogenSliderThumbF extends NitrogenSliderThumb {
		
		public function NitrogenSliderThumbF(val:Number) {
			super(val);
    }
		
		override protected function setupButton() {
			super.button = new NitrogenSliderThumbFBtn();
			addChild(super.button);
		}
		
		override protected function setupValueField(val:Number) {
			super.setupValueTF(val, -8, 0);
		}
	}
	
}
