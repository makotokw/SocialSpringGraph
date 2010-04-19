package
{
	import blz.google.socialgraph.events.*;
	import blz.google.socialgraph.webservice.*;
	import blz.twitter.events.*;
	import blz.twitter.webservice.*;
	
	import com.adobe.flex.extras.controls.springgraph.Item;
	
	import mx.collections.ArrayCollection;

	public class SsgNode extends Item
	{				
		[Bindable]
		public var name:String;
		[Bindable]
		public var imageUrl:String;
		[Bindable]
		public var link:String;
		
		public var maxChildNotes:Number = 20;
		public var nodes:ArrayCollection; 
		private var loaded:Boolean = false;
		
		private var webservice:GoogleSocialGraph;
		private var user:User;
		
		public function SsgNode(id:String) {
			super(id);
			this.name = GoogleSocialGraph.getAccountFromUrl(id);
			this.link = id;
			this.loadProfileImage();
		}
		
		public function init(webservice:GoogleSocialGraph):void {
			this.webservice = webservice;
		}
		
		public function load(force:Boolean = false):void {
			if (!loaded || force) {
				this.webservice.addEventListener(LookupEvent.LOOKUP_SUCCEEDED, onLookupCompleted);
				this.webservice.lookup(this.id, 0, 1, 1);
			}
		}
		
		public function loadProfileImage():void {
			//this.user.show(this.name);
			this.imageUrl = "http://purl.org/net/spiurl/"+this.name;
		}
		
		public function onUserShowCompleted(event:LoadEvent):void {
			var profile:Object = event.result;
			if (profile.hasOwnProperty("profile_image_url")) {
				this.imageUrl = profile.profile_image_url;
			}
		}
		
		public function isLoaded():Boolean {
			return this.loaded;
		}
		
		private function parseFriendLinks(friends:Object):ArrayCollection {
			var list:ArrayCollection = new ArrayCollection;
			for (var url:Object in friends) {
				var friend:Object = friends[url];
				if ((friend.types is Array && friend.types[0] != "me") || (friend.types is String && friend.types != "me")) {
					list.addItem(url.toString());
				}
			}
			return list;
		}
		
		public function onLookupCompleted(event:LookupEvent):void {
			try {
				var count:Number = 0;
				this.nodes = new ArrayCollection;
				var graph:Object = event.result;
				if (graph.hasOwnProperty("nodes")) {
					for (var node:Object in graph.nodes) {
						var info:Object = graph.nodes[node]; 
						if (info.hasOwnProperty("nodes_referenced") && info.hasOwnProperty("nodes_referenced_by")) {
							var follows:ArrayCollection = parseFriendLinks(info.nodes_referenced);
							var followers:ArrayCollection = parseFriendLinks(info.nodes_referenced_by);
							for (var i:Number=0; i<follows.length; i++) {
								var url:String = follows[i];
								if (followers.contains(url)) {
									var childNode:SsgNode = new SsgNode(url);
									childNode.maxChildNotes = this.maxChildNotes;
									childNode.init(this.webservice);
									this.nodes.addItem(childNode);
									if (maxChildNotes < count++) break;
								}
							}
						}
					}
				}				
				loaded = true;
			} catch (ex:Error) {}
			this.webservice.removeEventListener(LookupEvent.LOOKUP_SUCCEEDED, onLookupCompleted);
			this.dispatchEvent(new SsgNodeEvent(SsgNodeEvent.LOADED));
		}	
	}
}