package blz.google.socialgraph.events
{
	import flash.events.Event;
	
	public class LookupEvent extends Event
	{
		public static const LOOKUP_SUCCEEDED:String = "google_social_graph_lookup_succeeded";
		public static const LOOKUP_FAILED:String = "google_social_graph_lookup_failed";
		
		private var _q:String;
		private var _result:Object;
		
		public function LookupEvent(type:String, q:String, result:Object) {
			super(type);
			this._q = q;
			this._result = result;
		}
		
		public function get q():String { return _q; }
		public function get result():Object { return _result; }
	}
}