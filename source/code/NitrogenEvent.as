package code {

	import flash.events.Event;

  public class NitrogenEvent extends Event {

		public static const UPDATE_VIEWS:String = "updateViews";
		public static const RESTORE_VIEWS:String = "restoreViews";

    public function NitrogenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
    }

		override public function toString():String {
			return formatToString("NitrogenEvent", "type", "bubbles", "cancelable");
		}
		
		override public function clone():Event {
			return new NitrogenEvent(type, bubbles, cancelable);
		}
  }
}