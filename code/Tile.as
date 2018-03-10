package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	
	public class Tile extends MovieClip {
		
		public var properPosition: Vector3D;
		var typeOfTile: String;
		
		public function Tile() {
			// constructor code

		}
		
		public function SetProperPosition(){
			properPosition = new Vector3D(this.x, this.y, this.z);
		}


	}
	
}
