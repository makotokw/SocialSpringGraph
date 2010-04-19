package blz.twitter.webservice
{
	import blz.twitter.events.*;
	public class User extends API
	{
		public function User()
		{
		}
		
		public function show(screenName:String):void
		{
			var url:String = "http://api.twitter.com/1/users/show/"+screenName+".json";
			trace(url);
			this.getJSON(url);
		}
		
		override protected function onJsonLoaded(result:Object):void
		{
			trace(result);
			this.dispatchEvent(new LoadEvent(LoadEvent.LOAD_SUCCEEDED, result, null));
		}
	}
}