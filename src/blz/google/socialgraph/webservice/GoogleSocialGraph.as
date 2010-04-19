package blz.google.socialgraph.webservice
{		
	import blz.google.socialgraph.events.*;	
	import com.adobe.serialization.json.JSON;	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.*;	
		
	public class GoogleSocialGraph extends EventDispatcher
	{
		private static var urlBase:String = "http://socialgraph.apis.google.com";
		
		public function lookup(q:String, fme:Number, edo:Number, edi:Number): void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(urlBase + "/lookup?q=" + escape(q) + "&fme=" + fme + "&edo=" + edo + "&edi=" + edi);
			loader.addEventListener(Event.COMPLETE, loaderCompleted);
			loader.load(request);
			trace("send to "+request.url);
		}
		
		private function loaderCompleted(event:Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var result:Object = com.adobe.serialization.json.JSON.decode(loader.data);
			this.dispatchEvent(new LookupEvent(LookupEvent.LOOKUP_SUCCEEDED,"", result));
		}
		
		public static function getAccountFromUrl(url:String):String {
			var account:String = url.replace("http://twitter.com/","");
			return account;
		} 
	}
}