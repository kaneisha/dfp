package view.ui
{
	import model.vo.FoodVO;

	public class ListBackground extends ListBackgroundBase
	{
		private var _vo:FoodVO;
		private var _list:Array;
		
		public function ListBackground()
		{
			super();
		}

		public function get vo():FoodVO
		{
			return _vo;
		}

		public function set vo(value:FoodVO):void
		{
			_vo = value;
		}
		
		
	}
}