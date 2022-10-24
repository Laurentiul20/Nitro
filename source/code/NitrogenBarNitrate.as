package code {

  import flash.events.*;
	import flash.display.*;
	
  public class NitrogenBarNitrate extends Sprite {

    private const MAX_NITRATE_WHOLE:int = 4400;
		private const BAR_RULER_UNIT_WHOLE:int = 400;
    private const MAX_NITRATE_SUB:int = 2200;
		private const BAR_RULER_UNIT_SUB:int = 200;
		private const BAR_HEIGHT:int = 480;
		private const BAR_WIDTH:int = 63;
		private const BAR_TICK_WIDTH:int = 8;
		private const BAR_RULER_WIDTH:int = 40;
		
		private var data:NitrogenData;
		private var xBase:Number;
		private var yBase:Number;
		private var container:Sprite;
		private var compContainer:Sprite;
		private var maxNitrate;
		private var barRulerUnit;
		
    public function NitrogenBarNitrate(data:NitrogenData, xBase:Number, yBase:Number) {
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

      updateUsage(true);
		}
		
		public function updateUsage(niBarChanged:Boolean):void {
			if (niBarChanged) {
				setupComponents();
			}
			if (data.watershed == NitrogenConsts.WHOLE_NAME)
				updateUsageWhole();
			else
				updateUsageSub();
		}
		
		public function updateUsageWhole():void {
			var hNiToGulf:Number = Math.round(BAR_HEIGHT * data.nitrateFluxToGulf() / maxNitrate);
			var hDeNi:Number = Math.round(BAR_HEIGHT * data.denitrification() / maxNitrate);
			var hNiToWatershed:Number = Math.round(BAR_HEIGHT * data.nitrateFluxToWatershed() / maxNitrate);
			var xPos:Number = xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH;
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			var line:Shape = new Shape();
			line.graphics.lineStyle(1, NitrogenConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.beginFill(NitrogenConsts.PINK_COLOR);
			line.graphics.drawRect(xPos,
														 yBase - hNiToGulf,
														 BAR_WIDTH,
														 hNiToGulf);
			line.graphics.drawRect(xPos,
														 yBase - hDeNi - hNiToGulf,
														 BAR_WIDTH,
														 hDeNi);
			line.graphics.drawRect(xPos,
														 yBase - hNiToWatershed - hDeNi - hNiToGulf,
														 BAR_WIDTH,
														 hNiToWatershed);
			line.graphics.endFill();
			container.addChild(line);
			if (hNiToGulf > 0)
				NitrogenUtils.setupTextFieldC3(container, NitrogenConsts.NITRATES_TO_GULF_NAME,
																xPos, yBase - hNiToGulf, BAR_WIDTH, hNiToGulf, 12, true);
			if (hDeNi > 0)
				NitrogenUtils.setupTextFieldC3(container, NitrogenConsts.DENITRIFICATION_NAME,
																xPos, yBase - hDeNi - hNiToGulf, BAR_WIDTH, hDeNi, 12, true);
			if (hNiToWatershed > 0)
				NitrogenUtils.setupTextFieldC3(container, NitrogenConsts.NITRATE_ENTERING_WATERSHED_NAME,
																xPos, yBase - hNiToWatershed - hDeNi - hNiToGulf,
																BAR_WIDTH, hNiToWatershed, 12, true);
      addChildAt(container, 0);
		}
		
		public function updateUsageSub():void {
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			var dataSub:NitrogenDataSub = data.subSections;
			var hMO:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.MISSOURI_NAME) / maxNitrate);
			var hUpMS:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.UPPER_MISSISSIPPI_NAME) / maxNitrate);
			var hOH:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.OHIO_NAME) / maxNitrate);
			var hAR:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.ARKANSAS_RED_WHITE_NAME) / maxNitrate);
			var hTN:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.TENNESSEE_NAME) / maxNitrate);
			var hLoMS:Number = Math.round(BAR_HEIGHT * dataSub.nitrateToGulf(NitrogenConsts.LOWER_MISSISSIPPI_NAME) / maxNitrate);
			var xPos:Number = xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH;
			NitrogenUtils.setupTextFieldC2(container, NitrogenConsts.NITRATES_TO_GULF_NAME,
																xPos, yBase - BAR_HEIGHT - 40, BAR_WIDTH, 40, 12, true);
			var line:Shape = new Shape();
			// There is a green layer of background map - to make bar color match the map color;
			var hTotal:Number = hTN + hLoMS + hAR + hOH + hUpMS + hMO;
			line.graphics.beginFill(NitrogenConsts.BG_GREEN_COLOR);
			line.graphics.drawRect(xPos,
														 yBase - hTotal,
														 BAR_WIDTH,
														 hTotal);
			line.graphics.endFill();
			line.graphics.lineStyle(1, NitrogenConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			line.graphics.beginFill(NitrogenConsts.TN_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN,
														 BAR_WIDTH,
														 hTN);
			line.graphics.endFill();
			line.graphics.beginFill(NitrogenConsts.LO_MS_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN - hLoMS,
														 BAR_WIDTH,
														 hLoMS);
			line.graphics.endFill();
			line.graphics.beginFill(NitrogenConsts.AR_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN - hLoMS - hAR,
														 BAR_WIDTH,
														 hAR);
			line.graphics.endFill();
			line.graphics.beginFill(NitrogenConsts.OH_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN - hLoMS - hAR - hOH,
														 BAR_WIDTH,
														 hOH);
			line.graphics.endFill();
			line.graphics.beginFill(NitrogenConsts.UP_MS_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN - hLoMS - hAR - hOH - hUpMS,
														 BAR_WIDTH,
														 hUpMS);
			line.graphics.endFill();
			line.graphics.beginFill(NitrogenConsts.MO_COLOR, 0.5);
			line.graphics.drawRect(xPos,
														 yBase - hTN - hLoMS - hAR - hOH - hUpMS - hMO,
														 BAR_WIDTH,
														 hMO);
			line.graphics.endFill();
			container.addChild(line);
      addChildAt(container, 0);
		}
		
		private function setupComponents():void {
			if (compContainer && compContainer.parent)
				removeChild(compContainer);
			compContainer = new Sprite();
			if (data.watershed == NitrogenConsts.WHOLE_NAME) {
				maxNitrate = MAX_NITRATE_WHOLE;
				barRulerUnit = BAR_RULER_UNIT_WHOLE;
			}
			else {
				maxNitrate = MAX_NITRATE_SUB;
				barRulerUnit = BAR_RULER_UNIT_SUB;
			}
			// draw the box;
			var box:Shape = new Shape();
			box.graphics.lineStyle(2, NitrogenConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			box.graphics.drawRect(xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH,
														yBase - BAR_HEIGHT,
														BAR_WIDTH,
														BAR_HEIGHT);
			// draw the ticks;
			// draw the rulers;
			var dist:int = 0;
			var yDelta:int;
			while (dist <= maxNitrate) {
				yDelta = Math.round(BAR_HEIGHT * dist / maxNitrate);
				box.graphics.moveTo(xBase + BAR_RULER_WIDTH, yBase - yDelta);
				box.graphics.lineTo(xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH, yBase - yDelta);
				NitrogenUtils.setupTextFieldR2(compContainer,
															 String(dist),
															 xBase,
															 yBase - yDelta - 10,
															 BAR_RULER_WIDTH,
															 20,
															 12,
															 true);
				dist += barRulerUnit;
			}
			compContainer.addChild(box);
			// draw the thousand tonnes;
			NitrogenUtils.setupTextFieldC2(compContainer, 
														 NitrogenConsts.THOUSAND_TONNES_NAME,
														 xBase,
														 yBase - BAR_HEIGHT - 40,
														 BAR_RULER_WIDTH + BAR_TICK_WIDTH,
														 40,
														 12,
														 true);
			addChild(compContainer);
		}
		
	}
}
