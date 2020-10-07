package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var planes:Array<FlxSprite>;

	override public function create()
	{
		super.create();
		bgColor = FlxColor.fromRGB(153, 217, 234);
		add(new FlxSprite(0, 0, "assets/images/clouds.png"));

		planes = [];
		var numPlanes = 3;
		var distribution = FlxG.height / numPlanes;
		for (i in 0...numPlanes)
		{
			var plane = new FlxSprite(0, distribution * i, "assets/images/planeYellow3.png");
			var rng = FlxG.random.int(100, 300);
			plane.velocity.x = rng;
			planes.push(plane);
			add(plane);
		}

		FlxG.camera.target = planes[1];

		var secondTarget = planes[numPlanes - 1];
		secondTarget.color = FlxColor.LIME;
		createCamera(FlxG.width - Math.floor(FlxG.width / 4), FlxColor.ORANGE, secondTarget);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		for (plane in planes)
		{
			FlxSpriteUtil.screenWrap(plane);
		}
	}

	function createCamera(X:Int, Color:Int, Follow:FlxSprite):Void
	{
		var camera:FlxCamera = new FlxCamera(X, 10, Math.floor(FlxG.width / 5), Math.floor(FlxG.height / 5));
		camera.setScrollBoundsRect(0, 0, FlxG.width, FlxG.height);
		camera.bgColor = Color;
		camera.follow(Follow);
		FlxG.cameras.add(camera);
	}
}
