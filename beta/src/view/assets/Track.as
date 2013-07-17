package view.assets
{
	import flash.display.Sprite;

	public class Track extends Sprite
	{
		public function Track()
		{
			this.graphics.beginFill(0xcdcdcd);
			this.graphics.drawRoundRect(0,-8,300,16,5);
			this.graphics.endFill();
		}
	}
}