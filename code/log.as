package  {
	
	import flash.display.MovieClip;
	
	
	public class log extends MovieClip {
		
		var mEngine;
		
		var typeOfEntity = "log";
		
		var xPosition = -1;
		var riverPosition = 0;
		
		var logSpeed = stoutMath.RandomNumberBetween(15, 25)/1000; //different speeds cause logs to cross over each other
		
		public function log(pRiverPosition: Number, pEngine) {
			// constructor code
			mEngine = pEngine;
			
			riverPosition = pRiverPosition;
			xPosition = -1-Math.random()*3;
		}
		
		function Update(){
			xPosition += logSpeed;
			if (xPosition < 0) {
				this.scaleX = Math.min(Math.max(2+xPosition, 0), 1);
				this.scaleY = Math.min(Math.max(2+xPosition, 0), 1);
			} else {
				this.scaleX = 1;
				this.scaleY = 1;
			}
			this.x = isoEngine.ToIsometric(xPosition, riverPosition).x;
			this.y = isoEngine.ToIsometric(xPosition, riverPosition).y;
			if (xPosition > 11) {
				Delete();
			}
		}
		
		function Delete() {
			mEngine.entityList.splice(mEngine.entityList.indexOf(this), 1);
			this.parent.removeChild(this);
		}
		
	}
	
}
