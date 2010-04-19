package
{
	import flash.events.Event;
	public class SsgNodeEvent extends Event
	{
		// KIND
		public static const LOADED:String = "SsgNodeEvent_loaded";
		
		public var sender:SsgNode;
		public function SsgNodeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type,bubbles,cancelable);
		}
	}
}