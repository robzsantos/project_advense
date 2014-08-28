package mvc
{
	import com.Entity;
	import events.GameEvent;
	import events.InternalGameEventPublisher;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import mvc.GameModel;
	import flash.utils.getTimer;
	
	/**
	 * Refere-se ao Palco do jogo, assim compõe somente aquilo que precisa ser desenhado a cada cena
	 * 
	 * Classe responsável por todo o código de saída para o usuário (GUI)
	 * Responsabilidades:
		 * Renderização de informações
		 * Requisição de mudanças ao MODELO
		 * Enviar ações de usuário ao CONTROLADOR
	 * 
	 * @author RRS
	 */
	public class GameView extends Sprite
	{
		public static const STAGE_DIMENSIONS:Point = new Point(800, 600);
		
		private var gameModel:GameModel;
		
		private var middlePointStage:Point;
		
		//private var contentLimitPosX:Number;
		
		public function GameView($gModel:GameModel)
		{
			gameModel = $gModel;
			middlePointStage = new Point(STAGE_DIMENSIONS.x / 2, STAGE_DIMENSIONS.y / 2);			
			trace("Game View foi instanciado!");
			
			//this.addEventListener(Event.ENTER_FRAME,step);
		}
		
		/*private function step(e:Event):void 
		{
			gameModel.step();
		}*/
		
		public function addToStage($scn:Entity):void
		{
			this.addChild($scn);
			//contentLimitPosX = this.width - GameScene.SCENE_DIMENSIONS.x;
		}
		
		public function getTotalEntitiesOnStage():int
		{
			return this.numChildren;
		}
		
		public function getDepthIndex($value:Entity):int
		{
			return this.getChildIndex($value);
		}
		
		public function getEntityOnStage($index:int):Entity
		{
			return this.getChildAt($index) as Entity;
		}
		
		public function set setStartPositionScene($value:Point):void
		{
			this.x = $value.x;
			this.y = $value.y;
		}
		
		public function get getStartPositionScene():Point
		{
			var tempPoint:Point = new Point(this.x,this.y);
			return tempPoint;
		}
		
		public function closeCurtains():void
		{
			//mostrar uma animação de "loading", enquanto esconde os elementos que estão visiveis na cena atual.
			//chamar funções no modelo para remover eventos dos elementos visiveis
			//trace("Fechando cortinas e há = "+getTotalEntitiesOnStage());
			//gameModel.clearElements
			var gameEvPublisher = InternalGameEventPublisher.getInstance();
			
			gameEvPublisher.dispatch(new GameEvent(GameEvent.STAGE_ELEMENTS_ARE_HIDDEN));
		}
		
		public function removeElementsOnStage(... args)
		{
			var totalElementsToRemove:*;
			var i:int=0;
			
			if (args.length == 0)
			{
				while(getTotalEntitiesOnStage() > 0)
				{
					this.removeChildAt(0);
				}
			}
			else
			{
				totalElementsToRemove = args;
				for (i; i < totalElementsToRemove.length; i++)
				{
					this.removeChild(args[i]);
				}
			}
		}
		
		public function openCurtains():void
		{
			//retirar a animação de "loading" e mostrar os elementos na nova cena.
			var gameEvPublisher = InternalGameEventPublisher.getInstance();
			
			gameEvPublisher.dispatch(new GameEvent(GameEvent.STAGE_ELEMENTS_ARE_VISIBLE));
		}
		
		public function get getMiddlePointStageX():Number
		{
			return middlePointStage.x;
		}
		
		public function get getMiddlePointStageY():Number
		{
			return middlePointStage.y;
		}
	}	
}