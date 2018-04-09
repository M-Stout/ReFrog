package  {
	
	import flash.display.MovieClip;
	
	
	public class car extends MovieClip {
		
		var mEngine;
		
		var typeOfEntity = "car";
		
		var xPosition = -1;
		var roadPosition = 0;
		
		var carSpeed = 0.03;
		
		public function car(pRoadPosition: Number, pEngine) {
			// constructor code
			mEngine = pEngine;
			
			roadPosition = pRoadPosition;
			xPosition = -2-Math.random()*3;
		}
		
		function Update(){
			xPosition += carSpeed;
			if (xPosition < 0) {
				this.scaleX = Math.min(Math.max(2+xPosition, 0), 1);
				this.scaleY = Math.min(Math.max(2+xPosition, 0), 1);
			} else {
				this.scaleX = 1;
				this.scaleY = 1;
			}
			this.x = isoEngine.ToIsometric(xPosition, roadPosition).x;
			this.y = isoEngine.ToIsometric(xPosition, roadPosition).y;
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
