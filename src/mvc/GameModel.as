package mvc
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import com.Role;
	import com.LoaderExternalDocument;
	import com.GameWorld;
	import com.SceneryLevel;
	import com.Actor;
	import com.Entity;
	import events.InternalGameEventPublisher;
	import events.GameEvent;
	/**
	 * Refere-se ao Backstage (bastidores) do jogo, assim compõe todas as informações do mundo do jogo
	 * 
	 * Classe responsável por todo o código de jogabilidade
	 * Responsabilidades:
		 * Encapsula o estado da aplicação
		 * Responde consultas ao BD(dados externos)
		 * Expõe as funcionalidades da Aplicação
		 * Notifica Views de mudança
	 * @author RRS
	 */
	public class GameModel extends GameWorld
	{
		public static const ID_MAP:int = 1;
		public static const ID_AVATAR:int = 2;
		public static const ID_CENARIO_1:int = 3;
		
		public static const AVATAR_POSITION_LEFT:Point = new Point(76,546);
		public static const START_POSITION_RESIDENTIAL_STREET:Point = new Point(-16.35, 0);
		public static const START_POSITION_MAP:Point = new Point(24, 67);
		
		public static const URL_ROLES_ACTORS:String = "gameActorsRolesList.xml";
		public static const URL_DIALOG:String = "dialogueSimasA0.xml";
		//Mapa
		
		//Avatar
		
		//NPC
		
		//Mapa
		
		//Cenário
		
		//Balão de Alternativas
		
		//Barra de Humor
		
		//Verificar se mantém ou não o Dictionary
		//private var _entitiesInstantiated:Dictionary;
			
		private var sceneryLevel:SceneryLevel;
		private var loaderExternalContent:LoaderExternalDocument;
		private var actorRoles:Role;
		private var actorsList:Array;
		private var scenarioLayersList:Array;
		
		private var sceneBounds:Array;
		private var sceneListenerInputToPlayerMove:Object;
		
		public function GameModel($worldDimensions:Point)
		{
			var intGameEvPublisher:InternalGameEventPublisher;
			
			super($worldDimensions);
			//_entitiesInstantiated = new Dictionary(true);
			loaderExternalContent = new LoaderExternalDocument(URL_ROLES_ACTORS, URL_DIALOG);
			actorRoles = new Role(this);
			intGameEvPublisher = InternalGameEventPublisher.getInstance();
			intGameEvPublisher.addListener(this, new GameEvent(GameEvent.ROLE_IS_READY), deliverRoles);
			/*var mapGame:EntMap = new EntMap(this,ID_MAP,new Point(24, 67));
			addNewEntity(mapGame);*/
			//entitiesInstantiated[mapGame.category + mapGame.id] = mapGame;
			trace("Game Model instanciado!");
		}
		
		/*public function get entitiesInstantiated():Dictionary 
		{
			return _entitiesInstantiated;
		}
		
		public function addNewEntity($newEntity:Entity):void
		{
			entitiesInstantiated[$newEntity.category + $newEntity.id] = $newEntity;			
		}*/
		
		public function buildEntity($posElem:int):void
		{
			scenarioLayersList[$posElem] = new SceneryLevel(this,getScenarioLayers[$posElem], $posElem+1, "levelScenery", new Point(getScenarioLayers[$posElem].x, getScenarioLayers[$posElem].y), new Point(getScenarioLayers[$posElem].width, getScenarioLayers[$posElem].height));
		}
		
		public function updateActorsList($ind:int,$actor:Actor):void
		{
			actorsList[$ind] = $actor;
		}
		
		public function selectSceneElements($idScene:int):void
		{
			var tempContainer:*;
			
			switch($idScene)
			{
				case GameScene.SCENE_MAP:
					tempContainer = new AbsMapContainer();
				break;
				case GameScene.SCENE_RESIDENTIAL_STREET:
					tempContainer = new AbsResStreetContainer();
				break;
			}
			
			//PEGA A LISTA DE ATORES E LISTA DE CENÁRIOS
			scenarioLayersList = tempContainer.getScenarioLayers();
			actorsList = tempContainer.getActors();
			sceneBounds = tempContainer.getSceneBoundsToPlayer();
			sceneListenerInputToPlayerMove = tempContainer.getStartClickArea();
		}
		
		public function deliverRoles($publisher:InternalGameEventPublisher = null):void
		{
			if($publisher != null)
				$publisher.removeListener(this, new GameEvent(GameEvent.ROLE_IS_READY));
				
			updateActorsProperties();
			
			for (var i:int = 0; i < getActorsList.length; i++)
			{
				trace("Entrega pós = "+getActorsList[i].category + getActorsList[i].id);
				(getActorsList[i] as Actor).setActions = actorRoles.selectActionList(getActorsList[i].category + getActorsList[i].id);
			}
		}
		
		public function updateActorsProperties():void
		{
			for (var i:int = 0; i < getActorsList.length; i++)
			{
				for (var j:int = 0; j < getLoaderExternalContent.getXmlListNodesLength(0); j++)
				{
					if (getActorsList[i].getIdCat == getLoaderExternalContent.getNameId(0,j) && getActorsList[i].category == getLoaderExternalContent.getType(0,j))
					{
						getActorsList[i].id = getLoaderExternalContent.getIdActor(0,j);
						break;
					}
				}
			}
		}
		
		public function clearProperties():void 
		{
			actorsList = [];
			scenarioLayersList = [];
			sceneBounds = [];
			sceneListenerInputToPlayerMove = null;
		}
		
		public function notifyEdgesScenarioLevelVisibleOnStage($startPosScene:Point):void 
		{
			var tempScenarioRightEdge;
			var tempScenarioLeftEdge;
			var idScenario:int;
			
			//TODO: trabalhar com try-catch futuramente aqui
			
			if (scenarioLayersList.length > 0)
			{
				tempScenarioRightEdge = scenarioLayersList[0];
				tempScenarioLeftEdge = scenarioLayersList[0];
				
				for (var i:int = 1; i < scenarioLayersList.length; i++)
				{
					if (tempScenarioRightEdge.x + tempScenarioRightEdge.width < scenarioLayersList[i].x + scenarioLayersList[i].width)
						tempScenarioRightEdge = scenarioLayersList[i];
					if (tempScenarioLeftEdge.x > scenarioLayersList[i].x)
						tempScenarioLeftEdge = scenarioLayersList[i];
				}
				(tempScenarioRightEdge as SceneryLevel).setIsLastLevelVisible = true;
				(tempScenarioRightEdge as SceneryLevel).setLastPosX($startPosScene);
				(tempScenarioLeftEdge as SceneryLevel).setIsFirstLevelVisible = true;
			}
			else
			{
				trace("scenarioLayersList ESTÁ VAZIO!");
			}
		}
		
		public function get getScenarioLayers():Array
		{
			return scenarioLayersList;
		}
		
		public function get getActorsList():Array
		{
			return actorsList;
		}
		
		public function get getAreaToPlayerMove():Object
		{
			return sceneListenerInputToPlayerMove;
		}
		
		public function get getSceneryLevel():SceneryLevel
		{
			return sceneryLevel;
		}
		
		public function get getLoaderExternalContent():LoaderExternalDocument
		{
			return loaderExternalContent;
		}
		
		public function get getRoles():Role
		{
			return actorRoles;
		}
	}
}