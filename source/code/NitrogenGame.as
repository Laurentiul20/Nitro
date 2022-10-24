package code {

  import flash.display.*;
  import fl.containers.ScrollPane;
  import flash.events.Event;

  public class NitrogenGame extends Sprite {

    private var myStage:Stage;
		private var sp:ScrollPane;
		private var view:NitrogenView;

    public function NitrogenGame() {
			view = new NitrogenView();
			addChild(view);
			
			myStage = this.stage;
			myStage.scaleMode = StageScaleMode.NO_SCALE;
			myStage.align = StageAlign.TOP_LEFT;
			myStage.addEventListener(Event.RESIZE, onSWFResized, false, 0, true);
			
			sp = new ScrollPane();
			sp.move(0, 0);
			onSWFResized(null);
			sp.source = view;
			addChild(sp);
    }

		private function onSWFResized(e:Event):void {
			sp.setSize(stage.stageWidth, stage.stageHeight);
		}
		
  }
}