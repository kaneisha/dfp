package view.assets
{
	import flash.display.Sprite;
	
	public class Handle extends Sprite
	{
		public function Handle()
		{
			super();
			this.graphics.beginFill(0xcdcdcd);
			this.graphics.drawRoundRect(0,-8,300,16,5);
			this.graphics.endFill();
		}
	}
}