package com
{
	import events.GameEvent;
	import events.InternalGameEventPublisher;
	import flash.geom.Point;
	import mvc.GameController;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class GameSceneDirector 
	{
		private var gameScene:GameScene;
		private var gameController:GameController;
		
		private var idNextScene:int;
		
		public function GameSceneDirector($gScene:GameScene)
		{
			gameScene = $gScene;
			gameController = new GameController(this);
			
			var intGameEvPublisher = InternalGameEventPublisher.getInstance();
			intGameEvPublisher.addListener(this, new GameEvent(GameEvent.STAGE_ELEMENTS_ARE_HIDDEN), callScene);
			intGameEvPublisher.addListener(this, new GameEvent(GameEvent.STAGE_ELEMENTS_ARE_VISIBLE), ableSceneElements);
			
			//Chamar essa função apenas após carregar os dados do XML, posteriormente
			gameScene.createNewScene(GameScene.SCENE_MAP);
		}
		
		public function analyzeOnClickElem($target:*, $parentTarget:*, $localPoint:Point, $globalPoint:Point)
		{
			var tempActor:PlayerActor = null;
			
			for (var i:int = 0; i < gameScene.getGameModel.getActorsList.length; i++) 
			{
				if (gameScene.getGameModel.getActorsList[i].category == "player")
				{
					tempActor = gameScene.getGameModel.getActorsList[i];
				}
			}
			
			//Descobrir quem foi clicado e chamar a ação que deve ser tomada
			if ($target.parent is Actor)
			{
				trace("CLICADO = " + $target.parent.category + $target.parent.id+", objetivo = "+$target.parent.getCurrentAction().goal);
				if ($target.parent.category == "button" && $target.parent.getCurrentAction().goal == "changeScene")
				{
					//Chamar responsáveis por desativar elementos da tela e mostrar tela de loading.
					gameController.setEnableButtons = false;
					gameController.setEnableKeyboard = false;
					idNextScene = $target.parent.getCurrentAction().returnId;
					gameScene.getGameView.closeCurtains();
				}
				else if ($target.parent.category == "button")
				{//Provisório
					//Chamar próxima ação do ator
					$target.parent.act();
				}
			}
			else if (tempActor != null && $globalPoint.x > tempActor.x && $globalPoint.y > gameScene.getGameModel.getAreaToPlayerMove.posY)
			{//Verificar se o clique foi em qualquer area do palco
				//Chamar próxima ação do ator
				//$target.parent.act();
				//trace("Vai para a direita! | Pos y = " + tempActor.y + " | Clique na tela = " + $globalPoint.y);
				tempActor.setDirection = PlayerActor.MOVE_RIGHT;
				tempActor.move(gameScene.calcExactPositionClickedInX($globalPoint.x));
			}
			else if (tempActor != null && $globalPoint.x < tempActor.x && $globalPoint.y > gameScene.getGameModel.getAreaToPlayerMove.posY)
			{//Verificar se o clique foi em qualquer area do palco
				//Chamar próxima ação do ator
				//$target.parent.act();
				tempActor.setDirection = PlayerActor.MOVE_LEFT;
				tempActor.move(gameScene.calcExactPositionClickedInX($globalPoint.x));
				//trace("Vai para a esquerda!");
			}
		}
		
		/*public function callPressElem($key)
		{
			//TODO:: chamar o ator do tipo PLAYER e enviar a ação que deve ser tomada
			for (var i:int = 0; i < gameScene.getGameModel.getActorsList.length; i++) 
			{
				if (gameScene.getGameModel.getActorsList[i].category == "player")
				{
					gameScene.getGameModel.getActorsList[i].changeDirection($key);
					gameScene.getGameModel.getActorsList[i].act();
				}
			}
		}*/
		
		/*public function callReleaseElem($key)
		{
			//TODO:: chamar o ator do tipo PLAYER e enviar a ação que deve ser tomada
			for (var i:int = 0; i < gameScene.getGameModel.getActorsList.length; i++) 
			{
				if (gameScene.getGameModel.getActorsList[i].category == "player")
				{
					//gameScene.getGameModel.getActorsList[i].changeDirection($key);
					gameScene.getGameModel.getActorsList[i].act();
				}
			}
			
		}*/
		
		public function callScene($publisher:InternalGameEventPublisher)
		{
			gameScene.clearScene();
			gameScene.createNewScene(idNextScene);
		}
		
		public function ableSceneElements($publisher:InternalGameEventPublisher)
		{
			gameController.setEnableButtons = true;
			//gameController.setEnableKeyboard = true;
		}
		
		public function get getGameController():GameController
		{
			return gameController;
		}
	}
}