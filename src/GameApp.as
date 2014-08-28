package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import events.InputKeyboardPublisher;
	import events.InputMousePublisher;
	import mvc.GameController;
	import com.GameSceneDirector;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class GameApp extends Sprite
	{
		private var gameScene:GameScene;
		private var gameSceneDirector:GameSceneDirector;
		
		public function GameApp()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init($ev:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("The Baby is running! \o/");
			gameScene = new GameScene();
			gameSceneDirector = new GameSceneDirector(gameScene);
			
			var inputMouseSubscriber:InputMousePublisher = new InputMousePublisher(this.stage);
			var inputKeyboardSubscriber:InputKeyboardPublisher = new InputKeyboardPublisher(this.stage);
			inputMouseSubscriber.registerMouseEvent(gameSceneDirector.getGameController);
			inputKeyboardSubscriber.registerKeyboardEvent(gameSceneDirector.getGameController);
			
			this.addChild(gameScene.getGameView);
		}
	}
}