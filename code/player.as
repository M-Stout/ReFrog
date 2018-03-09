package  {
	
	import flash.display.MovieClip;
	import flash.display.Shader;
	
	
	
	public class player extends MovieClip {
		
		var mStage;
		
		var movementComponent;
		var inputComponent;
		
		var shadowObject;
		
		var introPlaying = true;
		var introAnimationPosition = -1;
		
		public function player(pStage) {
			// constructor code
			mStage = pStage;
			movementComponent = new MovementComponent(this);
			inputComponent = new InputComponent(this);
			gotoAndStop(1);
			CreateShadow();
		}
		
		function Update(){
			movementComponent.Update();
			inputComponent.Update();

			if (introPlaying){
				this.alpha = introAnimationPosition;
				introAnimationPosition+= 0.02;
				if(introAnimationPosition > 1){
					introPlaying = false;
					this.alpha = 1;
				}
			}
		}
		
		function CreateShadow(){
			shadowObject = new shadow();
			shadowObject.x = this.x;
			shadowObject.y = this.y;
			mStage.addChild(shadowObject);
		}
	}
	
}
