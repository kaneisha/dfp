package view
{
	import com.whipple.reusable.ui.LayoutBox;
	import com.whipple.reusable.ui.SliderManager;
	
	import event.FoodEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.FoodModel;
	import model.vo.FoodVO;
	
	import view.assets.Handle;
	import view.assets.Thing;
	import view.assets.Track;
	import view.ui.SearchItem;

	public class SearchView extends SearchViewBase
	{
		private var _list:Array;
		
		private var _layout:LayoutBox;
		private var _scrollHolder:Sprite;
		private var _masker:Sprite;
		private var _allTheThings2:Array;
		
		public function SearchView()
		{
			super();
			go.buttonMode = true;
			go.mouseChildren = true;
		
			//setupScrolling();
			
			_layout = new LayoutBox();
			addChild(_layout);
			_layout.x = 150;
			_layout.y = 275;
			
			
		}

		public function set list(value:Array):void
		{
			_list = value;
			createList();
//			setupScrolling();
		}
		
		private function createList():void
		{
		
			while(_layout.numChildren > 0)
			{
				_layout.removeChildAt(0);
			}
			
			for each (var vo:FoodVO in _list) 
			{
				var item:SearchItem = new SearchItem();
				item.vo = vo;
				item.addEventListener(MouseEvent.CLICK, onItemClick);
				_layout.addChild(item);
				
			
			}
			
			setupScrolling();
			
		}
		
		private function onItemClick(event:MouseEvent):void
		{
			var clickedItem:SearchItem = SearchItem(MouseEvent(event).currentTarget);
			
			var foodEvent:FoodEvent = new FoodEvent(FoodEvent.ITEM_CLICK)
			foodEvent.id = clickedItem.vo.id;
			dispatchEvent(foodEvent);
		}
		
		private function setupScrolling():void
		{
//			// Need a sprite to hold all of the Things
			_scrollHolder = new Sprite();
			_scrollHolder.y = 275;
			addChild(_scrollHolder);
//			
//			// We will mask the holder to only display what we want.
			_masker = new Sprite();
			_masker.graphics.beginFill(0xff0000);
			_masker.graphics.drawRect(0,0,307,207);
			_masker.graphics.endFill();
			_masker.y = 275;
			addChild(_masker);
//			
			_scrollHolder.mask = _masker;
			
			// Adding the things to the holder
//			for(var i:uint = 0; i < _list.length; i++)
//			{
//				var t:SearchItem = _list[i];
//				t.x = (t.width + 10) * i
				//_scrollHolder.addChild(_layout);
//				
				trace(_scrollHolder);
			//}
			
			// Creating and setting up our slider & manager
			var track:Track = new Track();
			var handle:Handle = new Handle();
			track.addChild(handle);
			
			track.x = 200;
			track.y = 450;
			addChild(track);
			var sMan:SliderManager = new SliderManager();
			sMan.setUpAssets(track,handle);
			sMan.addEventListener(Event.CHANGE,onScroll);
		}
		
		private function onScroll(event:Event):void
		{
			// Grab the percent from the slider manager.
			var pct:Number = SliderManager(Event(event).currentTarget).pct;
			
			// Math : percent * range of motion
			_scrollHolder.x = - pct * (_scrollHolder.width - _masker.width);
			
		}
		
	}
}