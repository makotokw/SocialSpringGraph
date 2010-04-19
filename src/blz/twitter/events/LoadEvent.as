package blz.twitter.events
{
	import flash.events.Event;
	public class LoadEvent extends Event
	{
		public static const LOAD_SUCCEEDED:String = "twitter_load_succeeded";
		public static const LOAD_FAILED:String = "twitter_load_failed";
		
		protected var _context:Object;
		protected var _result:Object;
		
		public function LoadEvent(type:String, result:Object, context:Object) {
			super(type);
			this._result = result;
		}
		
		public function get context():Object { return _context; }
		public function get result():Object { return _result; }
	}
}