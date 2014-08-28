package com
{
	import events.GameEvent;
	import events.InternalGameEventPublisher;
	import flash.utils.Dictionary;
	import mvc.GameModel;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class Role
	{
		private var actorsRoleList:Dictionary;
		
		private var gameWorld:GameWorld;
		
		private var contentLoaded:int;
		
		public function Role($gWorld:GameWorld)
		{
			var intGameEvPublisher:InternalGameEventPublisher = InternalGameEventPublisher.getInstance();
			
			intGameEvPublisher.addListener(this, new GameEvent(GameEvent.XML_LOADED), keepInfoRoles);
			gameWorld = $gWorld;
			contentLoaded = 0;
			actorsRoleList = new Dictionary(true);
		}
		
		public function keepInfoRoles($publisher:InternalGameEventPublisher):void
		{
			var nameIdObj:String;
			var tempActorObj:Object;
			
			contentLoaded++;
			if (contentLoaded == (gameWorld as GameModel).getLoaderExternalContent.getTotalDocumentsToLoad)
				$publisher.removeListener(this, new GameEvent(GameEvent.XML_LOADED));
			
			for (var i:int = 0; i < (gameWorld as GameModel).getLoaderExternalContent.getXmlListNodesLength(0); i++)
			{
				tempActorObj = new Object();
				tempActorObj.id = (gameWorld as GameModel).getLoaderExternalContent.getIdActor(0,i);
				tempActorObj.type = (gameWorld as GameModel).getLoaderExternalContent.getType(0,i);
				tempActorObj.actions = (gameWorld as GameModel).getLoaderExternalContent.getActionList(0,i);
				
				nameIdObj = tempActorObj.type + tempActorObj.id;
				
				actorsRoleList[nameIdObj] = tempActorObj;
			}
			
			$publisher.dispatch(new GameEvent(GameEvent.ROLE_IS_READY));
		}
		
		public function selectActionList($actorId:String):Array
		{
			return actorsRoleList[$actorId].actions;
		}
	}
}