package code {
	
	import flash.display.*;

  public class NitrogenWholeMapView extends Sprite {
		
    protected const BASE_X:Number = 20;
		protected const BASE_Y:Number = -16;

		protected var bgMap:MovieClip;
		
		public function NitrogenWholeMapView() {
		}
		
    protected function initChildren():void {
			setupMap();
			setupMapTitle();
		}
		
		protected function setupMap():void {
			bgMap = new WholeMapMC();
			bgMap.cacheAsBitmap = true;
			bgMap.x = BASE_X + 8;
			bgMap.y = BASE_Y + 23;
			addChild(bgMap);
		}
		
		protected function setupMapTitle():void {
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.THE_MISSISSIPPI_WATERSHED_NAME,
														 BASE_X + 421, BASE_Y + 103, 178, 64,
														 26);
		}
		
	}
}