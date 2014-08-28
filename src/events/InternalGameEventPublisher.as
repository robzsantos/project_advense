package events
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class InternalGameEventPublisher
	{
		private static var instance:InternalGameEventPublisher;
		private static var allowInstantiation:Boolean;
		protected var subscribers:Array;
		private var elemWasRemoved:Boolean;
		
		public static function getInstance():InternalGameEventPublisher
		{
			if (instance == null) 
			{
				allowInstantiation = true;
				instance = new InternalGameEventPublisher();
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function InternalGameEventPublisher()
		{
			subscribers = new Array();
			elemWasRemoved = false;
		}
		
		public function addListener($listener:Object,$ev:GameEvent,$fn:Function)
		{
			var objListener:Object = { listener:$listener,event:$ev, method:$fn };
			
			if (! listenerIsAdded(objListener))
				subscribers.push(objListener);
		}
		
		public function listenerIsAdded($objListener:Object):Boolean
		{
			for (var i:int = 0; i < subscribers.length; i++)
			{
				if (subscribers[i].listener == $objListener.listener && subscribers[i].event.name == $objListener.event.name)
					return true;
			}
			return false;
		}
		
		public function removeListener($listener:Object,$ev:GameEvent):void
		{
			for (var i:int = 0; i < subscribers.length; i++)
			{
				if (subscribers[i].listener == $listener && subscribers[i].event.name == $ev.name)
				{
					subscribers.splice(i, 1);
					elemWasRemoved = true;
				}
			}
		}
		
		public function dispatch($event:GameEvent):void
		{
			for (var i:int = 0; i < subscribers.length; i++)
			{
				if (subscribers[i].event.name == $event.name)
					subscribers[i].method(this);
				if (elemWasRemoved)
				{
					i--;
					elemWasRemoved = false;
				}
			}
		}
	}
}