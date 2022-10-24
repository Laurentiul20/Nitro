package code {

	import flash.display.*;
	import flash.events.*;
	import fl.controls.ComboBox;

  public class NitrogenView extends Sprite {

    private var data:NitrogenData;
		private var currentWatershedView:Sprite;
		private var latestNonPastWatershed:String;
		private var watershedCB:ComboBox;
		private var weatherCB:ComboBox;
		private var cropPriceIdxCB:ComboBox;
		private var nitrateBar:NitrogenBarNitrate;
		private var costsBar:NitrogenBarCosts;
		private var corn:NitrogenCorn;
		private var zone:NitrogenZone;
		// contains everything except for bg, title, and zone;
		private var container:Sprite;

    public function NitrogenView() {
			data = new NitrogenData();
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);
			
			currentWatershedView = null;
			setupBackground();
			this.addEventListener(NitrogenEvent.UPDATE_VIEWS, updateViews, false, 0, true);
			this.addEventListener(NitrogenEvent.RESTORE_VIEWS, restoreViews, false, 0, true);
			container = new Sprite();
			setupTitles();
			setupBars();
			setupCorn();
			setupHypoxicZone();
			setupComboBoxes();
			addChild(container);
		}
		
		// this background is added as a workaround of the small edge area being cut off by the scroll pane
		// when the scroll bars appear.
		private function setupBackground():void {
			var bg:Shape = new Shape();
			bg.graphics.beginFill(NitrogenConsts.BACKGROUND_COLOR);
			bg.graphics.drawRect(0, 0, 840, 700);
			bg.graphics.endFill();
			addChild(bg);
		}
		
		private function setupTitles():void {
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.GAME_TITLE,
														 185, 5.50, 400, 38.60,
														 31, true);
			NitrogenUtils.setupTextFieldC2(container,
														 NitrogenConsts.WATERSHED_NAME,
														 9, 4, 160, 20,
														 12, true);
			NitrogenUtils.setupTextFieldC2(container,
														 NitrogenConsts.WEATHER_NAME,
														 594, 4, 90, 20,
														 12, true);
			NitrogenUtils.setupTextFieldC2(container,
														 NitrogenConsts.CROP_PRICE_INDEX_NAME,
														 692, 4, 140, 20,
														 12, true);
		}
		
    private function setupComboBoxes():void {
			watershedCB = new NitrogenComboBox();
			watershedCB.move(9, 24);
			watershedCB.setSize(160, 22);
			watershedCB.prompt = NitrogenConsts.WATERSHED_NAME;
      watershedCB.addItem( { label: NitrogenConsts.WHOLE_NAME } );
      watershedCB.addItem( { label: NitrogenConsts.SUB_WATERSHEDS_NAME } );
      watershedCB.addItem( { label: NitrogenConsts.PAST_HYPOXIC_ZONES_NAME } );
      watershedCB.addEventListener(Event.CHANGE, watershedChanged, false, 0, true);
			container.addChild(watershedCB);
			
			weatherCB = new NitrogenComboBox();
			weatherCB.move(594, 24);
			weatherCB.setSize(90, 22);
			weatherCB.prompt = NitrogenConsts.WEATHER_NAME;
      weatherCB.addItem( { label: NitrogenConsts.WET_YEAR_NAME, data:2180 } );
      weatherCB.addItem( { label: NitrogenConsts.MEDIUM_NAME, data:1680 } );
      weatherCB.addItem( { label: NitrogenConsts.DRY_YEAR_NAME, data:1180 } );
      weatherCB.addEventListener(Event.CHANGE, weatherChanged, false, 0, true);
			container.addChild(weatherCB);
			
			cropPriceIdxCB = new NitrogenComboBox();
			cropPriceIdxCB.move(702, 24);
			cropPriceIdxCB.setSize(120, 22);
			cropPriceIdxCB.prompt = NitrogenConsts.CROP_PRICE_INDEX_NAME;
      cropPriceIdxCB.addItem( { label: NitrogenConsts.VERY_LOW_NAME, data:3 } );
      cropPriceIdxCB.addItem( { label: NitrogenConsts.LOW_NAME, data:4 } );
      cropPriceIdxCB.addItem( { label: NitrogenConsts.MEDIUM_NAME, data:5 } );
      cropPriceIdxCB.addItem( { label: NitrogenConsts.HIGH_NAME, data:6 } );
      cropPriceIdxCB.addItem( { label: NitrogenConsts.VERY_HIGH_NAME, data:7 } );
      cropPriceIdxCB.addEventListener(Event.CHANGE, cropPriceIdxChanged, false, 0, true);
			container.addChild(cropPriceIdxCB);
			
			updateComboBoxes();
			watershedChanged(null);
		}
		
		private function setupBars():void {
			nitrateBar = new NitrogenBarNitrate(data, 645, 646);
			container.addChild(nitrateBar);
			costsBar = new NitrogenBarCosts(data, 762, 646);
			container.addChild(costsBar);
		}
		
		private function setupCorn():void {
			corn = new NitrogenCorn(data, 0, 295);
			container.addChild(corn);
		}
		
		private function setupHypoxicZone():void {
			zone = new NitrogenZone(data, 325, 552);
			addChild(zone);
		}
		
		private function watershedChanged(e:Event):void {
			if (currentWatershedView) {
				removeChild(currentWatershedView);
				currentWatershedView = null;
			}
			var sel:String = watershedCB.selectedLabel;
			this.data.watershed = sel;
			if (sel == NitrogenConsts.WHOLE_NAME) {
				latestNonPastWatershed = sel;
				currentWatershedView = new NitrogenWholeView(data.whole);
			}
			else if (sel == NitrogenConsts.SUB_WATERSHEDS_NAME) {
				latestNonPastWatershed = sel;
				currentWatershedView = new NitrogenSubView(data.subSections);
			}
			else if (sel == NitrogenConsts.PAST_HYPOXIC_ZONES_NAME) {
				currentWatershedView = new NitrogenPastView(data.pastHypoxicZones);
        removeChild(container);
			}
			if (currentWatershedView)
			  addChildAt(currentWatershedView, 1);
			updateViewsNiBarChanged(true);
		}
		
		private function weatherChanged(e:Event):void {
			this.data.initialNitrateFlux = weatherCB.selectedItem.data;
			updateViews(null);
		}
		
		private function cropPriceIdxChanged(e:Event):void {
			this.data.cropPriceIndex = cropPriceIdxCB.selectedItem.data;
			updateViews(null);
		}
		
		private function updateViews(e:Event):void {
			updateViewsNiBarChanged(false);
		}

		private function restoreViews(e:Event):void {
			data.watershed = latestNonPastWatershed;
			addChild(container);
			updateComboBoxes();
			watershedChanged(null);
		}
		
		private function updateViewsNiBarChanged(niBarChanged:Boolean):void {
			if (!data.isPastData()) {
				this.nitrateBar.updateUsage(niBarChanged);
				this.costsBar.updateUsage();
				this.corn.updateUsage();
			}
			this.zone.updateUsage();
		}
		
		private function updateComboBoxes():void {
			var idx:int = -1;
			switch (data.initialNitrateFlux) {
				case 2180:
				  idx = 0;
					break;
				case 1680:
				  idx = 1;
					break;
				case 1180:
				  idx = 2;
					break;
			}
			weatherCB.selectedIndex = idx;
			
			idx = -1;
			switch (data.cropPriceIndex) {
				case 3:
				  idx = 0;
					break;
				case 4:
				  idx = 1;
					break;
				case 5:
				  idx = 2;
					break;
				case 6:
				  idx = 3;
					break;
				case 7:
				  idx = 4;
					break;
			}
			cropPriceIdxCB.selectedIndex = idx;
			
			idx = -1;
			switch (data.watershed) {
				case NitrogenConsts.WHOLE_NAME:
				  idx = 0;
					break;
				case NitrogenConsts.SUB_WATERSHEDS_NAME:
				  idx = 1;
					break;
				case NitrogenConsts.PAST_HYPOXIC_ZONES_NAME:
				  idx = 2;
					break;
			}
			watershedCB.selectedIndex = idx;
		}
		
  }
}