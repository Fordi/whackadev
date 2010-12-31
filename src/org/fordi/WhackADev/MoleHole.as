package org.fordi.WhackADev 
{
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Bryan Elliott
	 */
	public class MoleHole extends FlxGroup
	{
		private var _delegate:MoleHoleDelegate;
		private var _emptyHole:FlxSprite;
		private var _moleHole:FlxSprite;
		private var _hitHole:FlxSprite;
		private var _stubHole:FlxSprite;
		private var _initialized:Boolean;
		private var _hasMole:Number;
		private var _waiting:Number;
		
		private static const HIT :Number = 0;
		private static const MISS:Number = 1;
		private static const STUB:Number = 2;
		
		public function MoleHole(X:Number, Y:Number, Delegate:MoleHoleDelegate) {
			super();
			x = X;
			y = Y;
			_delegate = Delegate;
			_moleHole = new FlxSprite().loadGraphic(Delegate.moleHole());
			_moleHole.solid = false;
			_moleHole.visible = false;
			add(_moleHole, true);
			
			_hitHole = new FlxSprite().loadGraphic(Delegate.hitHole());
			_hitHole.solid = false;
			_hitHole.visible = false;
			add(_hitHole, true);
			
			_stubHole = new FlxSprite().loadGraphic(Delegate.stubHole());
			_stubHole.solid = false;
			_stubHole.visible = false;
			add(_stubHole, true);
			
			_emptyHole = new FlxSprite().loadGraphic(Delegate.emptyHole());
			_emptyHole.solid = false;
			_emptyHole.visible = true;
			add(_emptyHole, true);
			
			width = 96;
			height = 96;
			
			_waiting = _hasMole = -1;
			
		}
		private function initializeOnce():void {
			if (_initialized) return;
			if (FlxG.stage == null) return;
			FlxG.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_initialized = true;
		}
		private function onMouseUp(event:MouseEvent):void {
			//if (!overlapsPoint(FlxG.mouse.x, FlxG.mouse.y)) return;
		}
		public function reallyHideMole():void {
			_moleHole.visible = _hitHole.visible = _stubHole.visible = false;
			_emptyHole.visible = true;
			_waiting = -1;
		}
		public function hideMole(hideType:Number):void {
			if (_hasMole != -1) clearTimeout(_hasMole);
			_hasMole = -1;
			switch (hideType) {
				case HIT:
					_emptyHole.visible = _moleHole.visible = _stubHole.visible = false;
					_hitHole.visible = true;
					_waiting = setTimeout(reallyHideMole, 1000);
					_delegate.hitMole();
					break;
				case MISS:
					reallyHideMole();
					_delegate.missMole();
					break;
				case STUB:
					_hitHole.visible = _emptyHole.visible = _moleHole.visible = false;
					 _stubHole.visible = true;
					_waiting = setTimeout(reallyHideMole, 1000);
					_delegate.stubHammer();
					break;
			}
		}
		public function showMole():void {
			if (_hasMole != -1 || _waiting != -1) return;
			_hasMole = setTimeout(hideMole, 2000, MISS);
			_emptyHole.visible = _hitHole.visible = _stubHole.visible = false;
			_moleHole.visible = true;
		}
		override public function update():void {
			initializeOnce();
			super.update();
			if (_waiting != -1) return;
			
			if (overlapsPoint(FlxG.mouse.x, FlxG.mouse.y) && FlxG.mouse.pressed()) {
				hideMole(_hasMole == -1 ? STUB : HIT);
			}
		}
	}
}