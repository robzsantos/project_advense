package events
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class InputKeyboardPublisher
	{
		private var context:Stage;
		protected var subscribers:Array = new Array();
		
		public function InputKeyboardPublisher($stage:Stage):void
		{
			context = $stage;
			context.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			context.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function onKeyDown(e:KeyboardEvent):void 
		{
			for(var i:int = 0; i < subscribers.length; i++)
				subscribers[i].onKeyDown(e);
		}
		
		public function onKeyUp(e:KeyboardEvent):void 
		{
			for(var i:int = 0; i < subscribers.length; i++)
				subscribers[i].onKeyUp(e);
		}
		
		public function registerKeyboardEvent(listener: IKeyboardInput):void
		{
			subscribers.push(listener);
		}
		
		public function unregisterKeyboardEvent(listener: IKeyboardInput):void//Boolean
		{
			//return subscribers.splice(1,1,listener);
		}
	}
}