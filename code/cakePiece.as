package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;	
	
	public class cakePiece extends MovieClip {
		
		var mEngine;
		var mStage;
		
		var typeOfEntity = "cakePiece";
				
		var movementComponent;
		var collisionComponent;
		
		var shadowObject;
		
		var introPlaying = true;
		var introAnimationPosition = 2000;
		
		public function cakePiece(pEngine) {
			mEngine = pEngine;
			mStage = mEngine.mainStage;
			movementComponent = new MovementComponent(this);
			collisionComponent = new CollisionComponent(this);
			
			while (true) { //choose safe space to spawn cakepiece
				var possibleDropSite = new Vector3D(stoutMath.RandomNumberBetween(1, 8), stoutMath.RandomNumberBetween(1, 8), 0);
				if (collisionComponent.checkTile(possibleDropSite) == "grassTile"){
					movementComponent.currentPosition = new Vector3D(possibleDropSite.x, possibleDropSite.y, 0);
					break;
				}
			}
			
			gotoAndStop(stoutMath.RandomNumberBetween(1, 32));//randomly choosing which frame to display (only aesthetic)
			CreateShadow();
			
			
			collisionComponent.colliderCircleRadius = 1; //set the size of the collider for cake pieces
		}
		
		function Update(){
			movementComponent.Update();
			collisionComponent.Update();
			
			if (introPlaying){
				this.y = isoEngine.ToIsometric(movementComponent.currentPosition.x, movementComponent.currentPosition.y, introAnimationPosition-(movementComponent.currentPosition.x*50)).y;
				introAnimationPosition+= -20;
				//trace(introAnimationPosition);
				if(introAnimationPosition-(movementComponent.currentPosition.x*50) < 1){
					introPlaying = false;
				}
			}			
		}
		
		function Delete(){
			
			mEngine.cakePieces.splice(mEngine.cakePieces.indexOf(this), 1);
			mEngine.entityList.splice(mEngine.entityList.indexOf(this), 1);
			mStage.removeChild(this);
			
			mStage.removeChild(shadowObject);
			shadowObject = null;
			
			movementComponent = null;
			collisionComponent = null;
		}
		
		function CreateShadow(){
			shadowObject = new shadow();
			shadowObject.x = this.x;
			shadowObject.y = this.y;
			mStage.addChild(shadowObject);
		}
	}
	
}
