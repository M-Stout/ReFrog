package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.geom.Vector3D;
	import flash.utils.getDefinitionByName;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class kernel extends MovieClip {
		
		
		
		public function kernel() {
			// constructor code
			
			trace("Hello World (Kernel Constructor)");
			
			
			addEventListener(Event.ADDED_TO_STAGE, Loaded);
			
		}
		
		function Loaded(e:Event) {
			
			trace("Kernel Loaded!");
			
			this.removeEventListener(Event.ADDED_TO_STAGE, Loaded); // ensure Loaded events loads just once
			
			var mainIsoEngine = new isoEngine(stage);
						
		}
		
	}
	
}
