package view
{
	import model.vo.FoodVO;

	public class IngredientsView extends IngredientViewBase
	{
		private var _vo:FoodVO;
		
		public function IngredientsView()
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
			tfFoodName.text = _vo.name;
			tfIngredientList.text = _vo.ingredients;
		}

	}
}