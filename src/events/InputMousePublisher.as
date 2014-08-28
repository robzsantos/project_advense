package events
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author RRS
	 */
	public class InputMousePublisher
	{
		private var context:Stage;
		protected var subscribers:Array = new Array();
		
		public function InputMousePublisher($stage:Stage):void
		{
			context = $stage;
			context.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void 
		{
			for(var i:int = 0; i < subscribers.length; i++)
				subscribers[i].onClick(e);
		}
		
		public function registerMouseEvent(listener: IMouseInput):void
		{
			subscribers.push(listener);
		}
		
		public function unregisterMouseEvent(listener: IMouseInput):void//Boolean
		{
			//return subscribers.splice(1,1,listener);
		}
	}
}