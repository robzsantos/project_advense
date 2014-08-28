package com 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	public class ArrangeContainer extends Sprite
	{
		private var sceneTriggerPlayerMoveObj:Object;
		
		private var sceneBounds:Array;
		
		private var scenariosList:Array;
		
		private var actorsList:Array;
		//TODO:: implementar código que valide se os nomes de instancias são válidos dentro do FLA
		
		public function ArrangeContainer():void 
		{//separa cenarios e atores
			var elem:*;
			var subElem:*;
			var depthScenario:Array;
			var codeAct:String;
			var catAct:String;
			var idCatAct:int;
			var actorObj:Object;
			var sceneBoundsObj:Object;
			//var sceneTriggerPlayerMoveObj:Object;
			
			scenariosList = new Array();
			actorsList = new Array();
			sceneBounds = new Array();
			sceneTriggerPlayerMoveObj = null;
			
			for (var i:int=0; i<this.numChildren; i++)
			{
				elem = this.getChildAt(i);
				
				if (elem is MovieClip && elem.name.search(/scn/) != -1)
				{//achou um cenário
					for (var j:int=0; j<elem.numChildren; j++)
					{
						subElem = elem.getChildAt(j);
						depthScenario = elem.name.match(/\d*[0-9]/g);
						//TODO: avaliar necessidade do ID inter
						if (subElem is MovieClip && subElem.name.search(/act/) != -1)
						{//achou um ator
							codeAct = subElem.name.toLowerCase();
							
							if (codeAct.search(/pl/) != -1)
								catAct = "player";
							else if (codeAct.search(/inter/) != -1)
								catAct = "interactive_element";
							else if (codeAct.search(/npc/) != -1)
								catAct = "npc";
							else if (codeAct.search(/btn/) != -1)
								catAct = "button";
								
							idCatAct = subElem.name.match(/\d*[0-9]/g);
							//idAct = 0;
								
							actorObj = { depth:int(depthScenario[0]), act:subElem, category:catAct, idCat:idCatAct };
							actorsList.push(actorObj);
							elem.removeChild(subElem);
							j--;
							//trace(subElem.x);
						}
					}
					scenariosList.push(elem);
				}
				else if (elem is MovieClip && elem.name.search(/startClicks/) != -1)
				{
					//TODO: criar classe especifica para tratar os elementos abaixo
					sceneTriggerPlayerMoveObj = { posX:elem.x, posY:elem.y };
				}
				else if (elem is MovieClip && elem.name.search(/st/) != -1)
				{
					sceneBoundsObj = { posX:elem.x, posY:elem.y, width: elem.width, height:elem.height, id: elem.name.match(/\d*[0-9]/g) };
					sceneBounds.push(sceneBoundsObj);
				}
			}
		}
		
		public function getScenarioLayers():Array
		{
			return scenariosList;
		}
		
		public function getActors():Array
		{
			return actorsList;
		}
		
		public function getStartClickArea():Object
		{
			return sceneTriggerPlayerMoveObj;
		}
		
		public function getSceneBoundsToPlayer():Array
		{
			return sceneBounds;
		}
	}
}
