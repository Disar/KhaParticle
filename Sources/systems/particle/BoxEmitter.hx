package systems.particle;
import systems.particle.Particle;

/**
 * ...
 * @author Sidar Talei
 */

enum BoxSide {
	LEFT;
	RIGHT;
	TOP;
	BOTTOM;
}
 
class BoxEmitter extends IEmitter
{
	public var side:BoxSide;
	
	public var width:Float;
	public var height:Float;
	
	private var halfWidth:Float;
	private var halfHeight:Float;
	
	public function new(width:Float, height:Float,side:BoxSide) 
	{
		this.width = width;
		this.height = height;
		this.side = side;
		halfWidth = width / 2;
		halfHeight = height / 2;
		super();
	}
	
	override private function onParticleActivate(p:Particle):Void 
	{
		super.onParticleActivate(p);
		//Setup Particles
		switch(side)
		{
			case BoxSide.LEFT:
				p.x = x - halfWidth;
				p.y = (y - halfHeight) + Math.random() * (height + 1);
				p.vX = speed;
				p.vY = 0;
			case BoxSide.RIGHT:
				p.x = x + halfWidth;
				p.y = (y - halfHeight) + Math.random() * (height + 1);
				p.vX = -speed;
				p.vY = 0;
			case BoxSide.TOP:
				p.x = (x - halfWidth) + Math.random() * width+1;
				p.y = y - halfHeight;
				p.vX = 0;
				p.vY = speed;
			case BoxSide.BOTTOM:
				p.x = (x - halfWidth) + Math.random() * width+1;
				p.y =  y + halfHeight;
				p.vX = 0;
				p.vY = -speed;
		}
		
		p.sx = p.x;
		p.sy = p.y;
	}
	
}