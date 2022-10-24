package code {
	
	public class NitrogenSliderThumbW extends NitrogenSliderThumb {
		
		public function NitrogenSliderThumbW(val:Number) {
			super(val);
    }
		
		override protected function setupButton() {
			super.button = new NitrogenSliderThumbWBtn();
			addChild(super.button);
		}
		
		override protected function setupValueField(val:Number) {
			super.setupValueTF(val, -8, 10);
		}
	}
	
}
