package  {
	import flash.geom.Vector3D;
	
	public class CollisionComponent {

		var possessed;
		
		

		public function CollisionComponent(pObject) {
			//constructor code
			possessed = pObject;
		}
		
		
		
		public function Update(){
			
			if (kernel.tiles[Math.round(possessed.movementComponent.currentPosition.x)][Math.round(possessed.movementComponent.currentPosition.y)].typeOfTile == "waterTile"){
				trace("splash");
				
				var splashEffect = new splash(); 
				splashEffect.x = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).x;
				splashEffect.y = kernel.ToIsometric(Math.round(possessed.movementComponent.currentPosition.x), Math.round(possessed.movementComponent.currentPosition.y), 0).y;
				possessed.mStage.addChild(splashEffect);
				
				possessed.Delete();
			}
			
		}

	}
	
}
