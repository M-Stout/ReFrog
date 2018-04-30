package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	
	public class Tile extends MovieClip {
		
		public var properPosition: Vector3D;
		var typeOfTile: String;
		
		var biome = 1;
		
		public function Tile() {
			// constructor code
			

		}
		
		public function SetProperPosition(){
			properPosition = new Vector3D(this.x, this.y, this.z);
		}

		public function SetBiome(pBiome: int)
		{
			biome = pBiome;
			gotoAndStop(biome);
		}

	}
	
}
