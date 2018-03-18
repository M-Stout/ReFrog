package  {
	
	import flash.display.MovieClip;
	
	
	public class log extends MovieClip {
		
		var typeOfEntity = "log";
		
		var xPosition = -1;
		var riverPosition = 0;
		
		var logSpeed = kernel.RandomNumberBetween(15, 25)/1000;
		
		public function log(pRiverPosition: Number) {
			// constructor code
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
			this.x = kernel.ToIsometric(xPosition, riverPosition).x;
			this.y = kernel.ToIsometric(xPosition, riverPosition).y;
			if (xPosition > 11) {
				Delete();
			}
		}
		
		function Delete() {
			kernel.entityList.splice(kernel.entityList.indexOf(this), 1);
			this.parent.removeChild(this);
		}
		
	}
	
}
