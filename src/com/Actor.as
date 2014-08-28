package com
{
	import com.Entity;
	import com.GameWorld;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import mvc.GameModel;
	/**
	 * ...
	 * @author RRS
	 */
	public class Actor extends Entity 
	{
		private var scene:GameScene;
		private var objActor:*;
		private var actionsList:Array;
		private var lastAct:int;//////
		private var idCat:int;
		private var linkedSceneryLevelId:int;
		
		public function Actor($scene:GameScene,$world:GameWorld,$actor:*,$id:int,$category:String,$position:Point,$dimensions:Point,$idSceneryLevel:int)
		{
			super($world, $id, $category, $position, $dimensions);
			
			if ($actor.totalFrames == 1)
				objActor = $actor as Sprite;
			else 
			{
				objActor = $actor;
				if($category == "player")
					objActor.stop();
				objActor.mouseChildren = false;
			}
			
			scene = $scene;
			objActor.x = 0;
			objActor.y = 0;
			this.addChild($actor);
			dimensions.x = objActor.width;
			dimensions.y = objActor.height;
			lastAct = 0;
			idCat = $id;
			linkedSceneryLevelId = $idSceneryLevel;
		}
		
		public function buildActor($actor:MovieClip):void 
		{
			/* Que tipo de ator ele é: disparado pelo controlador/disparado por hitTest
			 * Todos disparam eventos
			 * Alguns possuem animações
			 * */
			/**/
		}
		
		/*
		 * Função para ser reescrita pelos filhos
		 * */
		public function act():void
		{
			
		}
		
		public function moveHorizontalToStart():void
		{
			this.x += PlayerActor.VELOCITY;
			//this.sceneryObject.x += PlayerActor.VELOCITY;
		}
		
		public function moveHorizontalToEnd():void
		{
			this.x -= PlayerActor.VELOCITY;
			//this.sceneryObject.x -= PlayerActor.VELOCITY;
		}
		
		public function getCurrentAction():Object
		{
			return actionsList[lastAct];
		}
		
		public function set setActions($value:Array):void
		{
			actionsList = $value;
		}
		
		override public function set id(value:int):void 
		{
			super.id = value;
		}
		
		public function get getIdCat():int 
		{
			return idCat;
		}
		
		public function get getObjActor():* 
		{
			return objActor;
		}
		
		public function get getScene():GameScene
		{
			return scene;
		}
		
		public function get getLinkedSceneryLevelId():int
		{
			return linkedSceneryLevelId;
		}
	}
}