package blz.twitter.webservice
{
	import blz.twitter.events.*;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*;	
	
	public class API extends EventDispatcher
	{
		public function API()
		{
		}
		
		protected function getJSON(url:String): void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(url);
			loader.addEventListener(Event.COMPLETE, loaderCompleted);
			loader.load(request);
			trace("send to "+request.url);
		}
		
		protected function loaderCompleted(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var result:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			this.onJsonLoaded(result);
		}
		
		protected function onJsonLoaded(result:Object):void
		{
			
		}
	}
}