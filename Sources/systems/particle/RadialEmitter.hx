package systems.particle;
import kha.math.Random;
import systems.particle.Particle;

/**
 * ...
 * @author Sidar Talei
 */
class RadialEmitter extends IEmitter {
	public var edgeSpawn:Bool = false;
	public var radiusX:Float = 50;
	public var radiusY:Float = 50;
	public var fromCenter:Bool = true;
	
	public var clamToEdge:Bool;
	
	public function new(){
		super();
		Random.init(16546456);
	}
	
	public function setRadius(r:Float) : Void {
		radiusX = radiusY = r;
	}
	
	override private function onParticleActivate(p:Particle):Void {
		super.onParticleActivate(p);
		
		if (edgeSpawn){
			 var a:Float = Math.random() * 361;
			 
			p.x = x + Math.cos(a * 180/Math.PI) * radiusX;
			p.y = y + Math.sin(a * 180/Math.PI) * radiusY;
			 
		}
		else if (!fromCenter){
			p.x = x + Math.cos(Math.random()*(Math.PI*2)) * (radiusX*Math.random());
			p.y = y + Math.sin(Math.random()*(Math.PI*2)) * (radiusY*Math.random());
		}
		else {
			 
			p.x = x; 
			p.y = y; 
		}
		
		p.sx = p.x;
		p.sy = p.y;
		
		p.vX = Random.getIn(Std.int(-speed),Std.int(speed));
		p.vY = Random.getIn(Std.int( -speed), Std.int(speed));
		
		
	}
	
	override public function processParticle(p:Particle):Void {
		super.processParticle(p);
		if (clamToEdge) {
			
			//Broken as fuuuuuuuuuuuuuuuuuuck
			if (p.x > x + radiusX) p.x = x + radiusX;
			else if (p.x < x -radiusX) p.x = x - radiusX;
			if (p.y > y + radiusY) p.y  = y + radiusY;
			else if (p.y < y - radiusY) p.y = y - radiusY;
		}
	}
	
	
}