package code {

  import flash.events.*;
	import flash.display.*;
	
  public class NitrogenBarCosts extends Sprite {

    private const MAX_COST:int = 10;
		private const BAR_RULER_UNIT:int = 1;
		private const BAR_HEIGHT:int = 480;
		private const BAR_WIDTH:int = 23;
		private const BAR_TICK_WIDTH:int = 8;
		private const BAR_RULER_WIDTH:int = 20;
		
		private var data:NitrogenData;
		private var xBase:Number;
		private var yBase:Number;
		private var container:Sprite;
		
    public function NitrogenBarCosts(data:NitrogenData, xBase:Number, yBase:Number) {
			this.data = data;
			this.xBase = xBase;
			this.yBase = yBase;
			
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
    }

    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

      setupComponents();
      updateUsage();
		}
		
		public function updateUsage():void {
			if (container && container.parent)
				removeChild(container);
			container = new Sprite();
			var xPos:Number = xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH;
			var line:Shape = new Shape();
			line.graphics.lineStyle(1, NitrogenConsts.BLACK_COLOR, 1,
															false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER, 1);
			var costF:Number = data.totalFertilizerCosts();
			var costW:Number = data.totalWetlandCosts();
			var hCostF:Number;
			var hCostW:Number;
			if (costF > MAX_COST) {
				drawRectangle(line, NitrogenConsts.RED_COLOR,
											xPos, yBase - BAR_HEIGHT, BAR_WIDTH, BAR_HEIGHT);
				container.addChild(line);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.FERTILIZER_REDUCTION_NAME,
																			 xPos + 3, yBase, BAR_HEIGHT, BAR_WIDTH,
																			 12);
			}
			else if (costF == 0) {
				if (costW <= MAX_COST) {
					hCostW = Math.round(BAR_HEIGHT * costW / MAX_COST);
					drawRectangle(line, NitrogenConsts.GREEN_COLOR,
												xPos, yBase - hCostW, BAR_WIDTH, hCostW);
					container.addChild(line);
					NitrogenUtils.setupTextFieldL1(container,
																				 NitrogenConsts.WETLAND_RESTORATION_NAME,
																				 xPos + 3, yBase, hCostW, BAR_WIDTH,
																				 12);
				}
				else {
					drawRectangle(line, NitrogenConsts.RED_COLOR,
												xPos, yBase - BAR_HEIGHT, BAR_WIDTH, BAR_HEIGHT);
					container.addChild(line);
					NitrogenUtils.setupTextFieldL1(container,
																				 NitrogenConsts.WETLAND_RESTORATION_NAME,
																				 xPos + 3, yBase, BAR_HEIGHT, BAR_WIDTH,
																				 12);
				}
			}
			else if (costW == 0) {
				hCostF = Math.round(BAR_HEIGHT * costF / MAX_COST);
				drawRectangle(line, NitrogenConsts.GREEN_COLOR,
											xPos, yBase - hCostF, BAR_WIDTH, hCostF);
				container.addChild(line);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.FERTILIZER_REDUCTION_NAME,
																			 xPos + 3, yBase, hCostF, BAR_WIDTH,
																			 12);
			}
			else if (costF + costW > MAX_COST) {
				hCostF = Math.round(BAR_HEIGHT * costF / MAX_COST);
				hCostW = BAR_HEIGHT - hCostF;
				drawRectangle(line, NitrogenConsts.GREEN_COLOR,
											xPos, yBase - hCostF, BAR_WIDTH, hCostF);
				drawRectangle(line, NitrogenConsts.RED_COLOR,
											xPos, yBase - BAR_HEIGHT, BAR_WIDTH, hCostW);
				container.addChild(line);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.FERTILIZER_REDUCTION_NAME,
																			 xPos + 3, yBase, hCostF, BAR_WIDTH,
																			 12);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.WETLAND_RESTORATION_NAME,
																			 xPos + 3, yBase - hCostF, hCostW, BAR_WIDTH,
																			 12);
			}
			else {
				hCostF = Math.round(BAR_HEIGHT * costF / MAX_COST);
				hCostW = Math.round(BAR_HEIGHT * costW / MAX_COST);
				drawRectangle(line, NitrogenConsts.GREEN_COLOR,
											xPos, yBase - hCostF, BAR_WIDTH, hCostF);
				drawRectangle(line, NitrogenConsts.GREEN_COLOR,
											xPos, yBase - hCostF - hCostW, BAR_WIDTH, hCostW);
				container.addChild(line);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.FERTILIZER_REDUCTION_NAME,
																			 xPos + 3, yBase, hCostF, BAR_WIDTH,
																			 12);
				NitrogenUtils.setupTextFieldL1(container,
																			 NitrogenConsts.WETLAND_RESTORATION_NAME,
																			 xPos + 3, yBase - hCostF, hCostW, BAR_WIDTH,
																			 12);
			}
			addChildAt(container, 0);
		}
		
		private function setupComponents():void {
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
			while (dist <= MAX_COST) {
				yDelta = Math.round(BAR_HEIGHT * dist / MAX_COST);
				box.graphics.moveTo(xBase + BAR_RULER_WIDTH, yBase - yDelta);
				box.graphics.lineTo(xBase + BAR_RULER_WIDTH + BAR_TICK_WIDTH, yBase - yDelta);
				NitrogenUtils.setupTextFieldR2(this,
															 String(dist),
															 xBase,
															 yBase - yDelta - 10,
															 BAR_RULER_WIDTH,
															 20,
															 12,
															 true);
				dist += BAR_RULER_UNIT;
			}
			addChild(box);
			// draw the dollar billion;
			NitrogenUtils.setupTextFieldC2(this, 
														 NitrogenConsts.DOLLAR_BILLION_NAME,
														 xBase + 5,
														 yBase - BAR_HEIGHT - 30,
														 BAR_RULER_WIDTH + BAR_TICK_WIDTH,
														 30,
														 12,
														 true);
		}
		
		private function drawRectangle(line:Shape, color:uint,
																	 x:Number, y:Number, w:Number, h:Number):void {
			line.graphics.beginFill(color);
			line.graphics.drawRect(x, y, w, h);
			line.graphics.endFill();
		}
	}
}
