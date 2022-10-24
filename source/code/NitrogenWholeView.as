package code {
	
	import flash.display.*;
	import flash.events.*;
  import fl.events.*;
  import flash.text.TextField;

  public class NitrogenWholeView extends NitrogenWholeMapView {
		
    private var data:NitrogenDataWhole;
		private var wetlandSlider:NitrogenSlider;
		private var fertilizerSlider:NitrogenSlider;
		private var restorableWetlands:NitrogenRestorableWetlands;
		
		public function NitrogenWholeView(data:NitrogenDataWhole) {
			super();
			this.data = data;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			super.initChildren();
			setupRestorableWetlands();
			setupTextFields();
			setupSliders();
		}
		
		private function setupTextFields():void {
			var tf:TextField = NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.FERTILIZER_REDUCTION_SYMBOL_NAME,
														 BASE_X + 110, BASE_Y + 205, 200, 34,
														 20, true);
			tf.textColor = NitrogenConsts.DARK_PURPLE_COLOR;
			tf.background = true;
			tf.backgroundColor = NitrogenConsts.BACKGROUND_COLOR;
			tf = NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.WETLAND_RESTORATION_SYMBOL_NAME,
														 BASE_X + 180, BASE_Y + 311, 200, 34,
														 20, true);
			tf.textColor = NitrogenConsts.CRAYOLA_BLUE_COLOR;
			tf.background = true;
			tf.backgroundColor = NitrogenConsts.BACKGROUND_COLOR;
		}
		
		private function setupSliders():void {
			fertilizerSlider = new NitrogenSlider(0, 100, data.fertilizer.value);
			fertilizerSlider.move(BASE_X + 177, BASE_Y + 240);
			fertilizerSlider.setSize(272, 30);
      fertilizerSlider.addEventListener(SliderEvent.CHANGE, fertilizerSliderChanged, false, 0, true);
			addChild(fertilizerSlider);
			wetlandSlider = new NitrogenSliderW(0, 100, data.wetland.value);
			wetlandSlider.move(BASE_X + 177, BASE_Y + 271);
			wetlandSlider.setSize(272, 30);
      wetlandSlider.addEventListener(SliderEvent.CHANGE, wetlandSliderChanged, false, 0, true);
			addChild(wetlandSlider);
		}
		
		private function setupRestorableWetlands():void {
			restorableWetlands = new NitrogenRestorableWetlands();
			addChild(restorableWetlands);
			restorableWetlands.updateUsage(data.wetland.value);
		}
		
    private function wetlandSliderChanged(e:SliderEvent):void {
			data.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
			restorableWetlands.updateUsage(e.target.value);
    }
		
    private function fertilizerSliderChanged(e:SliderEvent):void {
			data.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
	}
}