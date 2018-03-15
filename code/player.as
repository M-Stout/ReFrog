package  {
	
	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.geom.Point;
	import flash.events.*;	
	
	
	public class player extends MovieClip {
		
		var typeOfEntity = "player";
		
		var mStage;
		
		var movementComponent;
		var inputComponent;
		var collisionComponent;
		
		var shadowObject;
		
		var introPlaying = true;
		var introAnimationPosition = -1;
		
		var gameOverScreenInstance;
		
		public function player(pStage) {
			// constructor code
			mStage = pStage;
			movementComponent = new MovementComponent(this);
			inputComponent = new InputComponent(this);
			collisionComponent = new CollisionComponent(this);
			gotoAndStop(1);
			CreateShadow();
		}
		
		function Update(){
			movementComponent.Update();
			inputComponent.Update();
			collisionComponent.Update();
			
			if (introPlaying){
				if (gameOverScreenInstance){
					mStage.removeChild(gameOverScreenInstance);
					gameOverScreenInstance = null;
				}
				this.alpha = introAnimationPosition;
				introAnimationPosition+= 0.02;
				if(introAnimationPosition > 1){
					introPlaying = false;
					this.alpha = 1;
				}
			}
		}
		
		function Delete(){
			gameOverScreenInstance = new gameOverScreen();
			mStage.addChild(gameOverScreenInstance); //add game over
			kernel.gameTimer.stop(); //stop kernel update
			
			//THIS OLD CODE TOTALLY DELETES THE PLAYER, NEW CODE JUST HIDES AND PAUSES READY FOR RESET
			/*kernel.playerObject = null;
			kernel.entityList.splice(kernel.entityList.indexOf(this), 1);
			mStage.removeChild(this);
			
			mStage.removeChild(shadowObject);
			shadowObject = null;
			
			movementComponent = null;
			inputComponent = null;
			collisionComponent = null;*/
			
			this.visible=false;
			shadowObject.visible=false;
			
			//kernel.instance.RemoveAllInputListeners();
		}
		
		function CreateShadow(){
			shadowObject = new shadow();
			shadowObject.x = this.x;
			shadowObject.y = this.y;
			mStage.addChild(shadowObject);
		}
	}
	
}
