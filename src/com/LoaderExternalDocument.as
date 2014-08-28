package com 
{
	import events.GameEvent;
	import events.InternalGameEventPublisher;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author RRS
	 */
	public class LoaderExternalDocument
	{
		private var arXMLs:Array;
		private var xmlElement:XML;
		private var loader:URLLoader;
		private var totalDocumentsToLoad:int;
		
		public function LoaderExternalDocument(... args)
		{
			totalDocumentsToLoad = 1//args.length; - descomentar somente quando preparar código de leitura dos diálogos.
			
			for (var i:int = 0; i < args.length; i++)
			{
				var localLoader:URLLoader = new URLLoader();
				
				try
				{
					localLoader.load(new URLRequest(args[i]));
				}
				catch (e:Error)
				{
					trace("Falha no carregamento do arquivo "+e.name+". Motivo: "+e.message);
				}
				localLoader.addEventListener(ProgressEvent.PROGRESS, onProgressLoadingXML);
				localLoader.addEventListener(IOErrorEvent.IO_ERROR,onErrorLoadingXML);
				localLoader.addEventListener(Event.COMPLETE,processXML);
			}
			arXMLs = new Array();
		}
		
		private function onErrorLoadingXML(e:IOErrorEvent):void 
		{
			trace("Falha no carregamento do arquivo "+e.target+". Motivo: "+e.text);
		}
		
		private function onProgressLoadingXML(ev:ProgressEvent):void 
		{
			trace("Building...");
		}
		
		private function processXML(ev:Event):void
		{
			trace("End...");
			var gameEvPublisher = InternalGameEventPublisher.getInstance();
			
			xmlElement = new XML(ev.target.data);
			arXMLs.push(xmlElement);
			gameEvPublisher.dispatch(new GameEvent(GameEvent.XML_LOADED));
		}
		
		public function getName($indDocument:int,$ind:int):String
		{
			return arXMLs[$indDocument].children()[$ind].@name;
		}
		
		public function getNameId($indDocument:int,$ind:int):int
		{
			return arXMLs[$indDocument].children()[$ind].@name.match(/\d*[0-9]/g);
		}
		
		public function getType($indDocument:int,$ind:int):String
		{
			return arXMLs[$indDocument].children()[$ind].@type;
		}
		
		public function getIdActor($indDocument:int,$ind:int):int
		{
			return int(arXMLs[$indDocument].children()[$ind].@id);
		}
		
		public function getActionList($indDocument:int,$ind:int):Array
		{
			var tempArray:Array = new Array;
			
			for each (var nodes:XML in arXMLs[$indDocument].children()[$ind].*)
			{
				var newObj:Object = new Object();
				var content:String = nodes[0];
				//type= ["|'] - aspas duplas ou aspas simples - ([^"|']+) -  concatena com qualquer caracter que não seja aspas duplas ou aspas simples, sendo uma ou mais ocorrências
				//|id= - ou id=(literal)
				if (content.indexOf("type=") != -1 || content.indexOf("id=") != -1)
				{
					var contentSplitted:Array = content.match(/type=["|']([^"|']+)|id=["|']([^"|']+)/g);
					
					var typeContent:Array = contentSplitted[0].split('="');
					var idContent:Array = contentSplitted[1].split('="');
					
					newObj.id = int(nodes.@id);
					newObj.returnType = typeContent[1];
					newObj.returnId = int(idContent[1]);
					newObj.goal = String(nodes.@goal);
				}
				else
				{
					newObj.id = int(nodes.@id);
					newObj.returnType = content;
				}
				tempArray.push(newObj);
			}
			return tempArray;
		}
		
		public function getXmlListNodesLength($indDocument:int):int
		{
			return arXMLs[$indDocument].children().length();
		}

		public function get getTotalDocumentsToLoad():int
		{
			return totalDocumentsToLoad;
		}
	}
}