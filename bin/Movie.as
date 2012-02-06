use namespace 'flash.display';
use namespace 'flash.geom';

class Ball
{
	
	private var _radius : int;
	
	private var _position : Point = new Point();
	
	public function Ball()
	{
		// Bug in esc compiler where you can't call the super constructor!
	}
	
	protected function super$init(x : int, y : int, radius : int) : void
	{
		_position.x = x;
		_position.y = y;
		_radius = radius;
	}
	
	public function paint(graphics : Graphics) : void
	{
		graphics.drawCircle(x, y, radius);	
	}
	
	public function get x() : int { return _position.x; }
	public function get y() : int { return _position.y; }
	public function get radius() : int { return _radius; }
}

class ColourBall extends Ball
{
	
	private var _alpha : Number;
	
	private var _colour : int;
	
	public function ColourBall(x : int, y : int, radius : int, colour : int, alpha : Number)
	{
		super$init(x, y, radius);
		
		_alpha = alpha;
		_colour = colour;
	}
	
	override public function paint(graphics : Graphics) : void
	{
		graphics.beginFill(colour, alpha);
		
		super.paint(graphics);
	}
	
	public function get alpha() : int { return _alpha; }
	public function get colour() : int { return _colour; }
}

function randomBetween(a : int, b : int) : int 
{
	return Math.random() * (1 + b - a) + a;
}

class Movie extends Sprite
{
	public function Movie()
	{
		for(var i : int = 0; i < 1000; i++) {
			var ball : ColourBall = new ColourBall(	randomBetween(0, 400), 
													randomBetween(0, 400), 
													randomBetween(20, 50),
													randomBetween(0, 0xffffff),
													Math.random() * 0.8 + 0.2);
			ball.paint(graphics);
		}
	}
}