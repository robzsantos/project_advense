package 
{
	import flash.events.Event;
	import flash.geom.Point;
	import com.Actor;
	import com.ButtonActor;
	import com.Entity;
	import com.PlayerActor;
	import com.SceneryLevel;
	import mvc.GameModel;
	import mvc.GameView;

	/**
	 * Cria e Gerencia as cenas do jogo
	 * Armazena dados da Cena do jogo
	 * 
	 * Uma cena é composta pelo Palco, pelos Bastidores, pelos Cenários, pelos Atores
	 * @author RRS
	 */
	public class GameScene
	{
		public static const SCENE_MAP:int = 0;
		public static const SCENE_RESIDENTIAL_STREET:int = 1;
		public static const SCENE_RESTAURANT:int = 2;
		public static const SCENE_SHOPPING_STREET:int = 3;
		
		private var gameModel:GameModel;
		private var gameView:GameView;
		
		private var rightBoundScene:Boolean;
		private var leftBoundScene:Boolean;
		
		private var endMovePointInSceneAchieved:Boolean;
		private var endMovePointInSceneCalculated:Boolean;
		private var endMovePointInScene:Number;
		private var indexSceneryBaseToScrollHorizontal:int;
		
		private var currentScene:int;
		
		public function GameScene()
		{
			gameModel = new GameModel(GameView.STAGE_DIMENSIONS);
			gameView = new GameView(gameModel);
			
			rightBoundScene = false;
			leftBoundScene = true;
		}
		
		public function createNewScene($idScene:int):void
		{
			var contActor:int = 0;
			var hasActor:Boolean = true;
			var idLastScenarioLevelVisibleOnStage:int;
			
			currentScene = $idScene;
			gameModel.selectSceneElements($idScene);
			
			for (var i:int = 0; i < gameModel.getScenarioLayers.length; i++)
			{
				gameModel.buildEntity(i);
				
				if(gameModel.getScenarioLayers[i].numChildren > 0)
					gameView.addToStage(gameModel.getScenarioLayers[i]);
				
				(gameModel.getScenarioLayers[i] as SceneryLevel).depth = gameView.getDepthIndex(gameModel.getScenarioLayers[i]);
					
				if (gameModel.getScenarioLayers[i].width > GameView.STAGE_DIMENSIONS.x || gameModel.getScenarioLayers[i].x > GameView.STAGE_DIMENSIONS.x)
				{//horizontal
					(gameModel.getScenarioLayers[i] as SceneryLevel).setHorizontalScroll = true;
					trace("TEM SCROLL HORIZONTAL: ");
					trace("Nível = "+(gameModel.getScenarioLayers[i] as SceneryLevel).category+((gameModel.getScenarioLayers[i] as SceneryLevel).id - 1));
				}
				if (gameModel.getScenarioLayers[i].height > GameView.STAGE_DIMENSIONS.y || gameModel.getScenarioLayers[i].y > GameView.STAGE_DIMENSIONS.y)
				{//vertical
					(gameModel.getScenarioLayers[i] as SceneryLevel).setVerticalScroll = true;
					trace("TEM SCROLL VERTICAL: ");
					trace("Nível = "+(gameModel.getScenarioLayers[i] as SceneryLevel).category+((gameModel.getScenarioLayers[i] as SceneryLevel).id - 1));
				}				
				
				while(hasActor)
				{
					if (contActor < gameModel.getActorsList.length && gameModel.getActorsList[contActor].depth == i)
					{//Tem ator nessa cena?
						var positionActor = new Point(gameModel.getScenarioLayers[i].x + gameModel.getActorsList[contActor].act.x, gameModel.getScenarioLayers[i].y + gameModel.getActorsList[contActor].act.y);
						var actor:Actor;
						switch(gameModel.getActorsList[contActor].category)
						{
							case "button":
							case "interactive_element":
								actor = new ButtonActor(this, gameModel, gameModel.getActorsList[contActor].act, gameModel.getActorsList[contActor].idCat, gameModel.getActorsList[contActor].category, positionActor, new Point(0, 0),gameModel.getScenarioLayers[i].id);
							break;
							case "player":
								actor = new PlayerActor(this, gameModel, gameModel.getActorsList[contActor].act, gameModel.getActorsList[contActor].idCat, gameModel.getActorsList[contActor].category, positionActor, new Point(0, 0),gameModel.getScenarioLayers[i].id);
							break;
							default:
								actor = new Actor(this, gameModel, gameModel.getActorsList[contActor].act, gameModel.getActorsList[contActor].idCat, gameModel.getActorsList[contActor].category, positionActor, new Point(0, 0),gameModel.getScenarioLayers[i].id);
							break;
						}						
						gameModel.updateActorsList(contActor,actor);
						contActor++;
						gameView.addToStage(actor);
						actor.depth = gameView.getDepthIndex(actor);
					}
					else
						hasActor = false;
				}
				hasActor = true;
			}
			
			switch($idScene)
			{
				case GameScene.SCENE_MAP:
					gameView.setStartPositionScene = GameModel.START_POSITION_MAP;
				break;
				case GameScene.SCENE_RESIDENTIAL_STREET:
					gameView.setStartPositionScene = GameModel.START_POSITION_RESIDENTIAL_STREET;
					gameModel.deliverRoles();
					gameView.openCurtains();
				break;
			}
			gameModel.notifyEdgesScenarioLevelVisibleOnStage(gameView.getStartPositionScene);
			gameModel.mWorldDimensions = new Point(gameView.width, gameView.height);
		}
		
		public function clearScene():void
		{
			gameView.removeElementsOnStage();
			gameModel.clearProperties();
		}
		
		public function moveBackground($direction:int):void
		{
			for (var i = 0; i < gameModel.getScenarioLayers.length; i++)
			{
				if ((gameModel.getScenarioLayers[i] as SceneryLevel).getHorizontalScroll)
				{
					if ($direction == PlayerActor.MOVE_RIGHT)
					{
						gameModel.getScenarioLayers[i].moveHorizontalToEnd();
						if ((gameModel.getScenarioLayers[i] as SceneryLevel).getIsLastLevelVisible && (gameModel.getScenarioLayers[i] as SceneryLevel).x <= (gameModel.getScenarioLayers[i] as SceneryLevel).getLastPosX)
						{
							rightBoundScene = true;
						}
						leftBoundScene = false;
					}
					else
					{
						gameModel.getScenarioLayers[i].moveHorizontalToStart();
						if ((gameModel.getScenarioLayers[i] as SceneryLevel).getIsFirstLevelVisible && (gameModel.getScenarioLayers[i] as SceneryLevel).x >= (gameModel.getScenarioLayers[i] as SceneryLevel).getInitPosX)
						{
							leftBoundScene = true;
						}
						rightBoundScene = false;
					}
					
					for (var j = 0; j < gameModel.getActorsList.length; j++)
					{
						if ((gameModel.getScenarioLayers[i] as SceneryLevel).id == (gameModel.getActorsList[j] as Actor).getLinkedSceneryLevelId)
							if ($direction == PlayerActor.MOVE_RIGHT) gameModel.getActorsList[j].moveHorizontalToEnd();
							else gameModel.getActorsList[j].moveHorizontalToStart();
					}
				}
			}
			
			if (($direction == PlayerActor.MOVE_RIGHT && endMovePointInScene < 0 && gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x < endMovePointInScene) || 
			($direction == PlayerActor.MOVE_LEFT && endMovePointInScene < 0 && gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x > endMovePointInScene))
			{
				//trace("Acaba! val1 = "+endMovePointInScene+" | val2 = "+gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x);
				endMovePointInSceneAchieved = true;
			}
		}
		
		public function get getCurrentScene():int
		{
			return currentScene;
		}
		
		public function get getGameModel():GameModel
		{
			return gameModel;
		}
		
		public function get getGameView():GameView
		{
			return gameView;
		}
		
		public function get getMiddlePointSceneX():Number
		{
			return gameView.getMiddlePointStageX;
		}
		
		public function get getMiddlePointSceneY():Number
		{
			return gameView.getMiddlePointStageY;
		}
		
		public function get getRightBoundScene():Boolean
		{
			return rightBoundScene;
		}
		
		public function get getLeftBoundScene():Boolean
		{
			return leftBoundScene;
		}
		
		public function get getEndMovePointInSceneAchieved():Boolean 
		{
			return endMovePointInSceneAchieved;
		}
		
		public function get getEndMovePointInSceneCalculated():Boolean 
		{
			return endMovePointInSceneCalculated;
		}
		
		public function calcExactPositionClickedInX($pointClicked:Number):Number
		{
			var diffPosClicked:Number;
			var tempElement:Entity;
			var realPointClicked:Number;
			var distanceBetweenStartPointSceneAndActualScene:Number = 0;			
			var i:int;
			
			diffPosClicked = getMiddlePointSceneX - $pointClicked;
			
			endMovePointInSceneAchieved = false;
			endMovePointInSceneCalculated = false;
			
			if ((!rightBoundScene && !leftBoundScene) || (leftBoundScene && diffPosClicked < 0) || 
			(rightBoundScene && diffPosClicked > 0))
			{
				// os cantos não estão travados
				// OU o canto esquerdo da cena tá travado e o clique é maior que a posição central da cena
				// OU o canto direito da cena tá travado e o clique é menor que a posição central da cena
				for (i = 0; i < gameModel.getScenarioLayers.length; i++)
				{
					if ((gameModel.getScenarioLayers[i] as SceneryLevel).getHorizontalScroll)
					{
						tempElement = gameModel.getScenarioLayers[i] as SceneryLevel;
						indexSceneryBaseToScrollHorizontal = i;
						if (diffPosClicked < 0)
						{
							//cenario mover para esquerda
							//trace("Pos X esq = "+tempElement.x+" | clicked = "+$pointClicked+" | diff = "+diffPosClicked);
							if (tempElement.x > 0)
							{
								realPointClicked = (tempElement.x - diffPosClicked) * (-1);
							}
							else
							{
								realPointClicked = tempElement.x + diffPosClicked;
							}
						}
						else
						{
							//cenario mover para direita
							//trace("Pos X dir = "+tempElement.x+" | clicked = "+$pointClicked+" | diff = "+diffPosClicked);
							if (tempElement.x > 0)
							{
								realPointClicked = (tempElement.x + diffPosClicked)*(-1);
							}
							else 
							{
								realPointClicked = tempElement.x + diffPosClicked;
							}
						}
						endMovePointInScene = realPointClicked;
						endMovePointInSceneCalculated = true;
						break;
					}
				}
				//Se clicar num ponto da cena que se encontra dentro dos limites esquerdo ou direito da tela, recalcula posições nos ifs abaixo
				if (realPointClicked > gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].getInitPosX)
				{
					distanceBetweenStartPointSceneAndActualScene = gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x - gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].getInitPosX;
					//trace("BEGIN!\nPos X = "+gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].getInitPosX+"\ndistance = " + distanceBetweenStartPointSceneAndActualScene+"\ndiff = " + diffPosClicked+"\npoint = "+$pointClicked);				
				}
				else if (realPointClicked < gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].getLastPosX)
				{
					distanceBetweenStartPointSceneAndActualScene = gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x - gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].getLastPosX;
					//trace("END!\nPos X = "+gameModel.getScenarioLayers[indexSceneryBaseToScrollHorizontal].x+"distance = " + distanceBetweenStartPointSceneAndActualScene+"diff = " + diffPosClicked+"point = "+$pointClicked);
				}
				
				if (distanceBetweenStartPointSceneAndActualScene != 0)
				{
					realPointClicked = $pointClicked + ((~distanceBetweenStartPointSceneAndActualScene)+1);
					endMovePointInSceneCalculated = false;
				}
			}
			else
				realPointClicked = $pointClicked;
				
			trace(realPointClicked);
			return realPointClicked;
		}
	}
}