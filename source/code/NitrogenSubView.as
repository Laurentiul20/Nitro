package code {
	
	import flash.display.*;
	import flash.events.*;
  import fl.events.*;

  public class NitrogenSubView extends Sprite {

    private const BASE_X:Number = 20;
		private const BASE_Y:Number = 5;
    private const LEGEND_X:Number = BASE_X + 400;
		private const LEGEND_Y:Number = BASE_Y + 70;

		private var data:NitrogenDataSub;
		private var bgMap:MovieClip;
		private var fSliderLoMS:NitrogenSlider;
		private var wSliderLoMS:NitrogenSlider;
		private var dataLoMS:NitrogenDataSubItem;
		private var fSliderAR:NitrogenSlider;
		private var wSliderAR:NitrogenSlider;
		private var dataAR:NitrogenDataSubItem;
		private var fSliderOH:NitrogenSlider;
		private var wSliderOH:NitrogenSlider;
		private var dataOH:NitrogenDataSubItem;
		private var fSliderTN:NitrogenSlider;
		private var wSliderTN:NitrogenSlider;
		private var dataTN:NitrogenDataSubItem;
		private var fSliderUpMS:NitrogenSlider;
		private var wSliderUpMS:NitrogenSlider;
		private var dataUpMS:NitrogenDataSubItem;
		private var fSliderMO:NitrogenSlider;
		private var wSliderMO:NitrogenSlider;
		private var dataMO:NitrogenDataSubItem;

		public function NitrogenSubView(data:NitrogenDataSub) {
			this.data = data;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			setupMap();
			setupTextFields();
			setupLegend();
			setupSliders();
		}
		
		private function setupMap():void {
			bgMap = new SubMapMC();
			bgMap.cacheAsBitmap = true;
			bgMap.x = BASE_X + 8;
			bgMap.y = BASE_Y + 23;
			addChild(bgMap);
		}
		
		private function setupTextFields():void {
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.THE_MISSISSIPPI_WATERSHED_NAME,
														 BASE_X + 421, BASE_Y + 153, 178, 64,
														 26);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.MISSOURI_NAME,
														 BASE_X + 146, BASE_Y + 132, 105, 25,
														 24);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.UPPER_MISSISSIPPI_NAME,
														 BASE_X + 305, BASE_Y + 140, 104, 60,
														 24);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.OHIO_NAME,
														 BASE_X + 517, BASE_Y + 260, 72, 25,
														 24);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.ARKANSAS_RED_WHITE_NAME,
														 BASE_X + 135, BASE_Y + 316, 105, 60,
														 24);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.TENNESSEE_NAME,
														 BASE_X + 446, BASE_Y + 368, 112, 25,
														 24);
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.LOWER_MISSISSIPPI_NAME,
														 BASE_X + 323, BASE_Y + 433, 126, 60,
														 24);
		}
		
		private function setupLegend():void {
			var box:Shape = new Shape();
			box.graphics.lineStyle(1, NitrogenConsts.BLACK_COLOR, 1,
														 false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.beginFill(NitrogenConsts.WHITE_COLOR);
			// 36 = 4 + 12 + 4 + 12 + 4;
			box.graphics.drawRect(LEGEND_X, LEGEND_Y, 188, 36);
			box.graphics.endFill();
			box.graphics.beginFill(NitrogenConsts.PURPLE_COLOR);
			box.graphics.drawTriangles(Vector.<Number>([LEGEND_X + 6, LEGEND_Y + 4,
																									LEGEND_X + 18, LEGEND_Y + 4,
																									LEGEND_X + 12, LEGEND_Y + 15]));
			box.graphics.endFill();
			box.graphics.beginFill(NitrogenConsts.BLUE_COLOR);
			box.graphics.drawTriangles(Vector.<Number>([LEGEND_X + 12, LEGEND_Y + 21,
																									LEGEND_X + 6, LEGEND_Y + 32,
																									LEGEND_X + 18, LEGEND_Y + 32]));
			box.graphics.endFill();
			addChild(box);
			NitrogenUtils.setupTextFieldL2(this,
														NitrogenConsts.FERTILIZER_REDUCTION_SYMBOL_NAME,
														LEGEND_X + 20, LEGEND_Y, 170, 20,
														12, true);
			NitrogenUtils.setupTextFieldL2(this,
														NitrogenConsts.WETLAND_RESTORATION_SYMBOL_NAME,
														LEGEND_X + 20, LEGEND_Y + 16, 170, 20,
														12, true);
		}
		
		private function setupSliders():void {
			dataMO = data.getDataItem(NitrogenConsts.MISSOURI_NAME);
			fSliderMO = new NitrogenSlider(0, 100, dataMO.fertilizer.value);
			fSliderMO.move(BASE_X + 94, BASE_Y + 162);
			fSliderMO.setSize(165, 30);
      fSliderMO.addEventListener(SliderEvent.CHANGE, fSliderMOChanged, false, 0, true);
			addChild(fSliderMO);
			wSliderMO = new NitrogenSliderW(0, 100, dataMO.wetland.value);
			wSliderMO.move(BASE_X + 94, BASE_Y + 192);
			wSliderMO.setSize(165, 30);
      wSliderMO.addEventListener(SliderEvent.CHANGE, wSliderMOChanged, false, 0, true);
			addChild(wSliderMO);

			dataUpMS = data.getDataItem(NitrogenConsts.UPPER_MISSISSIPPI_NAME);
			fSliderUpMS = new NitrogenSlider(0, 100, dataUpMS.fertilizer.value);
			fSliderUpMS.move(BASE_X + 301, BASE_Y + 196);
			fSliderUpMS.setSize(165, 30);
      fSliderUpMS.addEventListener(SliderEvent.CHANGE, fSliderUpMSChanged, false, 0, true);
			addChild(fSliderUpMS);
			wSliderUpMS = new NitrogenSliderW(0, 100, dataUpMS.wetland.value);
			wSliderUpMS.move(BASE_X + 301, BASE_Y + 227);
			wSliderUpMS.setSize(165, 30);
      wSliderUpMS.addEventListener(SliderEvent.CHANGE, wSliderUpMSChanged, false, 0, true);
			addChild(wSliderUpMS);

			dataOH = data.getDataItem(NitrogenConsts.OHIO_NAME);
			fSliderOH = new NitrogenSlider(0, 100, dataOH.fertilizer.value);
			fSliderOH.move(BASE_X + 441, BASE_Y + 289);
			fSliderOH.setSize(165, 30);
      fSliderOH.addEventListener(SliderEvent.CHANGE, fSliderOHChanged, false, 0, true);
			addChild(fSliderOH);
			wSliderOH = new NitrogenSliderW(0, 100, dataOH.wetland.value);
			wSliderOH.move(BASE_X + 441, BASE_Y + 320);
			wSliderOH.setSize(165, 30);
      wSliderOH.addEventListener(SliderEvent.CHANGE, wSliderOHChanged, false, 0, true);
			addChild(wSliderOH);

			dataAR = data.getDataItem(NitrogenConsts.ARKANSAS_RED_WHITE_NAME);
			fSliderAR = new NitrogenSlider(0, 100, dataAR.fertilizer.value);
			fSliderAR.move(BASE_X + 185, BASE_Y + 371);
			fSliderAR.setSize(165, 30);
      fSliderAR.addEventListener(SliderEvent.CHANGE, fSliderARChanged, false, 0, true);
			addChild(fSliderAR);
			wSliderAR = new NitrogenSliderW(0, 100, dataAR.wetland.value);
			wSliderAR.move(BASE_X + 185, BASE_Y + 402);
			wSliderAR.setSize(165, 30);
      wSliderAR.addEventListener(SliderEvent.CHANGE, wSliderARChanged, false, 0, true);
			addChild(wSliderAR);

			dataTN = data.getDataItem(NitrogenConsts.TENNESSEE_NAME);
			fSliderTN = new NitrogenSlider(0, 100, dataTN.fertilizer.value);
			fSliderTN.move(BASE_X + 434, BASE_Y + 397);
			fSliderTN.setSize(165, 30);
      fSliderTN.addEventListener(SliderEvent.CHANGE, fSliderTNChanged, false, 0, true);
			addChild(fSliderTN);
			wSliderTN = new NitrogenSliderW(0, 100, dataTN.wetland.value);
			wSliderTN.move(BASE_X + 434, BASE_Y + 428);
			wSliderTN.setSize(165, 30);
      wSliderTN.addEventListener(SliderEvent.CHANGE, wSliderTNChanged, false, 0, true);
			addChild(wSliderTN);

			dataLoMS = data.getDataItem(NitrogenConsts.LOWER_MISSISSIPPI_NAME);
			fSliderLoMS = new NitrogenSlider(0, 100, dataLoMS.fertilizer.value);
			fSliderLoMS.move(BASE_X + 361, BASE_Y + 489);
			fSliderLoMS.setSize(165, 30);
      fSliderLoMS.addEventListener(SliderEvent.CHANGE, fSliderLoMSChanged, false, 0, true);
			addChild(fSliderLoMS);
			wSliderLoMS = new NitrogenSliderW(0, 100, dataLoMS.wetland.value);
			wSliderLoMS.move(BASE_X + 361, BASE_Y + 520);
			wSliderLoMS.setSize(165, 30);
      wSliderLoMS.addEventListener(SliderEvent.CHANGE, wSliderLoMSChanged, false, 0, true);
			addChild(wSliderLoMS);
		}

    private function wSliderMOChanged(e:SliderEvent):void {
			dataMO.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderMOChanged(e:SliderEvent):void {
			dataMO.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }

    private function wSliderUpMSChanged(e:SliderEvent):void {
			dataUpMS.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderUpMSChanged(e:SliderEvent):void {
			dataUpMS.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }

    private function wSliderOHChanged(e:SliderEvent):void {
			dataOH.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderOHChanged(e:SliderEvent):void {
			dataOH.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }

    private function wSliderARChanged(e:SliderEvent):void {
			dataAR.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderARChanged(e:SliderEvent):void {
			dataAR.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }

    private function wSliderTNChanged(e:SliderEvent):void {
			dataTN.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderTNChanged(e:SliderEvent):void {
			dataTN.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }

    private function wSliderLoMSChanged(e:SliderEvent):void {
			dataLoMS.wetland.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
		
    private function fSliderLoMSChanged(e:SliderEvent):void {
			dataLoMS.fertilizer.value = e.target.value;
			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
    }
	}
}