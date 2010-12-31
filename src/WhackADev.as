package {
	import org.flixel.*;
	import org.fordi.WhackADev.MenuState;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	
	[Frame(factoryClass="Preloader")]

	public class WhackADev extends FlxGame {
		public function WhackADev():void {
			super(320,240,MenuState, 2);
			FlxState.bgColor = 0xffffffff;
			useDefaultHotKeys = true;
		}
	}
}
