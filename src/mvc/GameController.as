package mvc
{
	import com.Entity;
	import com.GameSceneDirector;
	import events.IMouseInput;
	import events.IKeyboardInput;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Classe responsável pela gestão de entrada do usuário (listeners)
	 * Responsabilidades:
		 * Define o comportamento da aplicação
		 * Mapeia ações para utilizar Modelos
		 * Seleciona Views para exibição
		 * Um para cada funcionalidade
	 * @author RRS
	 */
	public class GameController implements IMouseInput, IKeyboardInput
	{
		private var gameSceneDirector:GameSceneDirector;
		private var enableButtons:Boolean;
		private var enableKeyboard:Boolean;
		
		public function GameController($director:GameSceneDirector)
		{
			//TODO:: criar classes especializadas em recepção de entradas de Mouse/Teclado - se necessário
			gameSceneDirector = $director;
			enableButtons = true;
			enableKeyboard = false;
			
			trace("Game Controller foi instanciado!");
		}
		
		/* INTERFACE IMouseInput */
		
		public function onClick($ev:MouseEvent):void 
		{
			var localPoint:Point;
			var globalPoint:Point;
			
			if (enableButtons)
			{
				localPoint = new Point($ev.localX, $ev.localY);
				globalPoint = new Point($ev.stageX, $ev.stageY);
				
				gameSceneDirector.analyzeOnClickElem($ev.target,$ev.currentTarget,localPoint,globalPoint);
			}
		}
		
		public function onDown($ev:MouseEvent):void 
		{
			
		}
		
		public function onUp($ev:MouseEvent):void 
		{
			
		}
		
		public function onOut($ev:MouseEvent):void 
		{
			
		}
		
		public function onOver($ev:MouseEvent):void 
		{
			
		}
		
		/* INTERFACE IKeyboardInput */
		
		public function onKeyDown( $ev:KeyboardEvent ):void
		{
			//Responde, das teclas filtradas uma delas foi clicada!			
			/*if (enableKeyboard)
			{
				if ($ev.keyCode == Keyboard.LEFT)
				{
					trace("Apertei a tecla = " + $ev.charCode + " ou " + $ev.keyCode);
					gameSceneDirector.callPressElem("LEFT");
				}
				else if ($ev.keyCode == Keyboard.RIGHT)
				{
					gameSceneDirector.callPressElem("RIGHT");
				}
			}*/
		}
		
		public function onKeyUp( $ev:KeyboardEvent ):void
		{
			/*if (enableKeyboard)
			{
				if ($ev.keyCode == Keyboard.LEFT)
				{
					trace("Soltei a tecla = " + $ev.charCode + " ou " + $ev.keyCode);
					gameSceneDirector.callReleaseElem("LEFT");
				}
				else if ($ev.keyCode == Keyboard.RIGHT)
				{
					gameSceneDirector.callReleaseElem("RIGHT");
				}
			}*/
		}
		
		public function set setEnableButtons(value:Boolean):void 
		{
			enableButtons = value;
		}
		
		public function set setEnableKeyboard(value:Boolean):void 
		{
			enableKeyboard = value;
		}
	}	
}