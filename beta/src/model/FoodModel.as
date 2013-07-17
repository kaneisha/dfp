package model
{
	import event.FoodEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import model.vo.FoodVO;
	
	import view.ui.ListBackground;
	import view.ui.SecondBackground;
	
	public class FoodModel extends EventDispatcher
	{
		private var _list:Array;
		private var _vo:FoodVO;
		public static const url:String = "http://wddbs.com/~dfp/proxy.php?url=";
		
		public function FoodModel()
		{
			super();
		}
		
		public function search(search:String):void
		{
			trace(search);
			
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest(url + "http://api.nutritionix.com/v1/search/" + search + "?appId=58e7409d&appKey=ea55d470d93bafbab65a666b2541abcf"));
			ul.addEventListener(Event.COMPLETE, onSearchComplete);
		}
		
		private function onSearchComplete(event:Event):void
		{
			_list = [];
			
			var jsonData:Object = JSON.parse(Event(event).currentTarget.data);
			
			for each(var result:Object in jsonData.hits)
			{
				var vo:FoodVO = new FoodVO();
				vo.item = result.fields.item_name;
				vo.id = result._id;
				
				_list.push(vo);
			}
			
			dispatchEvent(new FoodEvent(FoodEvent.ARRAY_COMPLETE));
			
//			for(var i:int = 0; i < _list.length; i++)
//			{
//				var odd:Number = i % 2;
//				
//				if(odd != 0)
//				{
//					var bg:ListBackground = new ListBackground();
//					bg.x = 150;
//					bg.y = 275;
//				}
//				else{
//					var sbg:SecondBackground = new SecondBackground();
//				}
//				
//			}
			
		}
		
		public function item(id:String):void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest(url + "http://api.nutritionix.com/v1/item/" + id + "?appId=58e7409d&appKey=ea55d470d93bafbab65a666b2541abcf"));
			ul.addEventListener(Event.COMPLETE, onItemComplete);
		}
		
		protected function onItemComplete(event:Event):void
		{
			_vo = new FoodVO();
			
			var jsonData:Object = JSON.parse(Event(event).currentTarget.data);
			
			if(jsonData.nf_ingredient_statement == null || jsonData.status_code == 400)
			{
				_vo.ingredients = "Not Available";
				_vo.name = jsonData.item_name;
			}
			else
			{
				_vo.ingredients = jsonData.nf_ingredient_statement;
				_vo.name = jsonData.item_name;
			}
			
			dispatchEvent(new FoodEvent(FoodEvent.VO_COMPLETE));
		}
		
		public function get list():Array
		{
			return _list;
		}

		public function get vo():FoodVO
		{
			return _vo;
		}

		public function set list(value:Array):void
		{
			_list = value;
		}


	}
}