package code {
	
	import flash.display.*;
	import flash.events.*;
  import fl.events.*;
	import fl.controls.*;
	import fl.data.*;
	import flash.text.TextFormat;

  public class NitrogenPastView extends NitrogenWholeMapView {
		
    private var data:NitrogenDataPast;
		private var yearCB:ComboBox;
		private var backBtn:Button;
		
		public function NitrogenPastView(data:NitrogenDataPast) {
			super();
			this.data = data;
			addEventListener(Event.ADDED, setupChildren, false, 0, true);
		}
		
    private function setupChildren(e:Event):void {
			removeEventListener(Event.ADDED, setupChildren);

			super.initChildren();
			setupTitle();
			setupComboBox();
			setupButton();
		}
		
		private function setupTitle():void {
			NitrogenUtils.setupTextFieldC2(this,
														 NitrogenConsts.YEAR_NAME,
														 9, 4, 160, 20,
														 12, true);
		}
		
		private function setupComboBox():void {
			yearCB = new NitrogenComboBox();
			yearCB.move(9, 24);
			yearCB.setSize(160, 22);
			yearCB.dataProvider = data.dataProvider;
      yearCB.addEventListener(Event.CHANGE, yearChanged, false, 0, true);
			yearCB.rowCount = yearCB.dataProvider.length;
			addChild(yearCB);
			yearCB.selectedIndex = data.selectedIndex();
			yearChanged(null);
		}
		
		private function yearChanged(e:Event):void {
			data.selectedYear = int(yearCB.selectedLabel);
 			dispatchEvent(new NitrogenEvent(NitrogenEvent.UPDATE_VIEWS, true));
		}
		
		private function setupButton():void {
			backBtn = new Button();
			backBtn.move(700, 24);
			backBtn.setSize(100, 30);
			backBtn.label = NitrogenConsts.GO_BACK_NAME;
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			backBtn.setStyle("textFormat", tf);
			backBtn.addEventListener(MouseEvent.CLICK, buttonClicked, false, 0, true);
			addChild(backBtn);
		}
		
		private function buttonClicked(e:MouseEvent):void {
			dispatchEvent(new NitrogenEvent(NitrogenEvent.RESTORE_VIEWS, true));
		}
	}
}