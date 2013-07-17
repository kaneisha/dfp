package
{
	import com.whipple.reusable.ui.LayoutBox;
	
	import event.FoodEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.FoodModel;
	import model.vo.FoodVO;
	
	import view.HomeView;
	import view.IngredientsView;
	import view.SearchView;
	import view.ui.ListBackground;
	import view.ui.SearchItem;
	import view.ui.SecondBackground;
	
	[SWF(width="308", height="398", backgroundColor="0x666666")]
	
	public class Main extends Sprite
	{
		private var _foodModel:FoodModel;
		
		private var _searchView:SearchView;
		private var _ingredientsView:IngredientsView;
		private var _homeView:HomeView;
		
		public function Main()
		{
			_foodModel = new FoodModel();
			_foodModel.addEventListener(FoodEvent.ARRAY_COMPLETE, onSearchComplete);
			_foodModel.addEventListener(FoodEvent.VO_COMPLETE, onItemComplete);
			
			_homeView = new HomeView();
			addChild(_homeView);
			_homeView.homebtn.addEventListener(MouseEvent.CLICK, onSearchClick);
			
			_searchView = new SearchView();
			//addChild(_searchView);
			_searchView.addEventListener(FoodEvent.ITEM_CLICK, onItemClick);
			_searchView.go.addEventListener(MouseEvent.CLICK, onSearchSeachClick);
			
			_ingredientsView = new IngredientsView();
			_ingredientsView.search_icon.addEventListener(MouseEvent.CLICK, onSearchIndredientsClick);
		}
		
		protected function onSearchSeachClick(event:MouseEvent):void
		{
			addChild(_ingredientsView)
			removeChild(_ingredientsView);
			
			addChild(_searchView);
			
			_foodModel.search(_searchView.tfsearch.text);
			
			_searchView.tfsearch.text = "";
			_ingredientsView.tfReSearch.text = "";
		}
		
		protected function onSearchIndredientsClick(event:MouseEvent):void
		{
			addChild(_ingredientsView)
			removeChild(_ingredientsView);
			
			addChild(_searchView);
			
			_foodModel.search(_ingredientsView.tfReSearch.text);
			
			_searchView.tfsearch.text = "";
			_ingredientsView.tfReSearch.text = "";
		}
		
		protected function onSearchClick(event:MouseEvent):void
		{
			_foodModel.search(_homeView.tfHomeSearch.text);
			removeChild(_homeView);
			addChild(_searchView);
		}
		
		protected function onSearchComplete(event:Event):void
		{
			_searchView.list = _foodModel.list;
		}
		
		private function onItemClick(event:FoodEvent):void
		{
			//addChild(_searchView);
			_foodModel.item(FoodEvent(event).id);
			
		}
		
		protected function onItemComplete(event:Event):void
		{
			// bit of a hack to remove the search view
			addChild(_searchView);
			removeChild(_searchView);
			
			_ingredientsView.vo = _foodModel.vo;
			addChild(_ingredientsView);
			
			
		}
		
				
	}
}