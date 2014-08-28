package com
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class ButtonActor extends Actor
	{
		
		public function ButtonActor($scene:GameScene,$world:GameWorld,$actor:*,$id:int,$category:String,$position:Point,$dimensions:Point,$idSceneryLevel:int)
		{
			super($scene, $world, $actor, $id, $category, $position, $dimensions,$idSceneryLevel);
		}
		
		override public function act():void
		{
			/*Código provisório da cena 1 para mostrar alertar usuário que tela não está pronta*/
			
			/*TORNAR O ACT PARTICULAR PARA CADA ATOR POR CLASSES OU SEGMENTAR POR TIPO NESSA FUNÇÃO.*/
			
			var nextScreen:int = getCurrentAction().returnId;
			var tempText:String = "ainda não está pronto/a, tente outros locais...";
			switch(nextScreen)
			{
				default:
					trace(getCurrentAction().returnType+" "+tempText);
				break;
			}
		}
	}
	
}