package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;	
	
	public class cakePiece extends MovieClip {
		
		var typeOfEntity = "cakePiece";
		
		var mStage;
		
		var movementComponent;
		var collisionComponent;
		
		var shadowObject;
		
		var introPlaying = true;
		var introAnimationPosition = 1600;
		
		public function cakePiece(pStage) {
			mStage = pStage;
			movementComponent = new MovementComponent(this);
			collisionComponent = new CollisionComponent(this);
			
			while (true) { //choose safe space to spawn cakepiece
				var possibleDropSite = new Vector3D(kernel.RandomNumberBetween(1, 8), kernel.RandomNumberBetween(1, 8), 0);
				if (collisionComponent.checkTile(possibleDropSite) == "grassTile"){
					movementComponent.currentPosition = possibleDropSite;
					movementComponent.targetPosition = possibleDropSite;
					break;
				}
			}
			movementComponent.Move(0, 0, 100);
			
			gotoAndStop(kernel.RandomNumberBetween(1, 8));
			CreateShadow();
		}
		
		function Update(){
			movementComponent.Update();
			collisionComponent.Update();
			
			if (introPlaying){
				this.y = kernel.ToIsometric(movementComponent.currentPosition.x, movementComponent.currentPosition.y, introAnimationPosition-(movementComponent.currentPosition.x*50)).y;
				introAnimationPosition+= -20;
				//trace(introAnimationPosition);
				if(introAnimationPosition-(movementComponent.currentPosition.x*50) < 1){
					introPlaying = false;
				}
			}			
		}
		
		function Delete(){
			
			kernel.cakePieces.splice(kernel.cakePieces.indexOf(this), 1);
			kernel.entityList.splice(kernel.entityList.indexOf(this), 1);
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
