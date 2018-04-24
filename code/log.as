package  {
	
	import flash.display.MovieClip;
	
	
	public class log extends MovieClip {
		
		var mEngine;
		var mStage;
		
		var typeOfEntity = "log";
		
		var movementComponent;
		var collisionComponent;
		
		var shadowObject;
				
		var logSpeed = stoutMath.RandomNumberBetween(5, 25)/1000; //different speeds cause logs to cross over each other
		
		public function log(pRiverPosition: Number, pEngine) {
			// constructor code
			mEngine = pEngine;
			mStage = mEngine.mainStage;
			
			movementComponent = new MovementComponent(this);
			collisionComponent = new CollisionComponent(this);
			
			movementComponent.floatingObject = true;
			
			movementComponent.currentPosition.y = pRiverPosition;
			movementComponent.currentPosition.x = -1-Math.random()*3;
			
			collisionComponent.ignoreBoundingBoxChecks = true;
			collisionComponent.colliderCircleRadius = 0.9;
		}
		
		function Update(){
			movementComponent.Update();
			collisionComponent.Update();
			
			movementComponent.currentVelocity.x = logSpeed;
			
			//make it bigger until 0, make if smaller after 10. delete at 15 (for clean up, it's already invisible by then)
			if (movementComponent.currentPosition.x < 0) {
				this.scaleX = Math.min(Math.max(2+movementComponent.currentPosition.x, 0), 1);
				this.scaleY = Math.min(Math.max(2+movementComponent.currentPosition.x, 0), 1);
			} else if (movementComponent.currentPosition.x > 10) {
				this.scaleX = Math.min(Math.max(11-movementComponent.currentPosition.x, 0), 1);
				this.scaleY = Math.min(Math.max(11-movementComponent.currentPosition.x, 0), 1);
				if (movementComponent.currentPosition.x > 15) {
					Delete();
				}
			} else {
				this.scaleX = 1;
				this.scaleY = 1;
			}
			
		}
		
		function Delete() {
			mEngine.entityList.splice(mEngine.entityList.indexOf(this), 1);
			this.parent.removeChild(this);
		}
		
	}
	
}
