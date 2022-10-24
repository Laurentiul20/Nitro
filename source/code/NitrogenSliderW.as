package code {
	
	import flash.display.*;	
	import flash.text.TextField;
  import flash.text.*;
	
	// this NitrogenSliderW is for wetland;
	public class NitrogenSliderW extends NitrogenSlider {

		private var barContainer:Sprite;
		private var minValue:TextField;
		private var maxValue:TextField;

		public function NitrogenSliderW(min:Number, max:Number, val:Number) {
			super(min, max, val);
			
			minValue = NitrogenUtils.setupTextFieldC2(this,
											NitrogenConsts.STRING_ZERO,
											-5, 0, 10, 16,
											12, true);
			minValue.mouseEnabled = false;
			
			// the x location will be changed in setSize();
			maxValue = NitrogenUtils.setupTextFieldC2(this,
											String(maximum),
											-5, 0, 10, 16,
											12, true);
			maxValue.mouseEnabled = false;
		}
		
		override protected function setupSliderThumb(val:Number):void {
			thumb = new NitrogenSliderThumbW(val);
			thumb.y = 3;
		}
		
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if (w > 0 && h > 0) {
				maxValue.x = w - maxValue.getBounds(this).width / 2;
			}
		}

		override protected function draw():void {
 			drawBar();
			super.draw();
		}
		
		private function drawBar():void {
			clearBar();
			barContainer = new Sprite();
			var line:Shape = new Shape();
			line.graphics.lineStyle(5, NitrogenConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 3);
			line.graphics.moveTo(0, 0);
			line.graphics.lineTo(_width, 0);
			barContainer.addChild(line);
			addChild(barContainer);
		}
		
		private function clearBar():void {
			if (!barContainer || !barContainer.parent) { return; }
			removeChild(barContainer);
		}
	}
}
