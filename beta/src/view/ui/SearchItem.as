package view.ui
{
	import model.vo.FoodVO;

	public class SearchItem extends SearchItemBase
	{
		private var _vo:FoodVO;
		
		public function SearchItem()
		{
			super();
		}

		public function set vo(value:FoodVO):void
		{
			_vo = value;
			updateTextFields();
		}
		
		private function updateTextFields():void
		{
			tfIngredients.text = _vo.item;
		}

		public function get vo():FoodVO
		{
			return _vo;
		}

	}
}