package com
{
	import flash.geom.Point;
	import flash.events.Event;
	import mvc.GameModel;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class PlayerActor extends Actor
	{
		public static const MOVE_LEFT:int = 0;
		public static const MOVE_RIGHT:int = 1;
		public static const VELOCITY:int = 5;//4 é o valor ideal para o cenário da rua residencial
		
		private var endMovePoint:Number;
		private var isMoving:Boolean;
		private var direction:int;
		
		public function PlayerActor($scene:GameScene,$world:GameWorld,$actor:*,$id:int,$category:String,$position:Point,$dimensions:Point,$idSceneryLevel:int)
		{
			super($scene, $world, $actor, $id, $category, $position, $dimensions, $idSceneryLevel);
		}
		
		override public function act():void
		{
			/*Código provisório da cena 1 para mostrar alertar usuário que tela não está pronta*/
			
			/*TORNAR O ACT PARTICULAR PARA CADA ATOR POR CLASSES OU SEGMENTAR POR TIPO NESSA FUNÇÃO.*/
			
			var action:String = getCurrentAction().returnType;
			switch(action)
			{
				default:
					trace("FALHOU!");
				break;
			}
		}
		
		public function move(pointClicked:Number = NaN):void
		{
			if (!isMoving)
			{
				//trace("Middle stage = "+super.getScene.getMiddlePointSceneX);
				this.addEventListener(Event.ENTER_FRAME, checkMovePlayer);
			}
			
			//enquanto o movimento só acontece na horizontal, a preocupação fica somente com a posição X clicada
			if (pointClicked > 0)
				endMovePoint = pointClicked;
			
			isMoving = true;
			if (direction == MOVE_RIGHT) 
			{
				super.getObjActor.scaleX = 1;
				if (this.x >= super.getScene.getMiddlePointSceneX && !super.getScene.getRightBoundScene)
				{
					super.getScene.moveBackground(direction);
				}
				else
					this.x += VELOCITY;
			}
			else
			{
				super.getObjActor.scaleX = -1;
				if (this.x <= super.getScene.getMiddlePointSceneX && !super.getScene.getLeftBoundScene)
				{
					super.getScene.moveBackground(direction);
				}
				else
					this.x -= VELOCITY;
			}
			super.getObjActor.gotoAndStop("walk");
		}
		
		public function checkMovePlayer($ev:Event):void
		{
			if ((this.x >= endMovePoint && direction == MOVE_RIGHT && !super.getScene.getEndMovePointInSceneCalculated) || (this.x <= endMovePoint && direction == MOVE_LEFT && !super.getScene.getEndMovePointInSceneCalculated) || super.getScene.getEndMovePointInSceneAchieved)
			{
				//trace("STOP! charX = "+this.x+" | endPoint = "+endMovePoint+" | direction = "+direction+" | pointScene = "+super.getScene.getEndMovePointInSceneAchieved);
				isMoving = false;
				this.removeEventListener(Event.ENTER_FRAME, checkMovePlayer);
				super.getObjActor.gotoAndStop("tired");
			}
			else
				this.move();
		}
		
		public function set setDirection($direction:int):void
		{
			direction = $direction;
		}
		
	}
}