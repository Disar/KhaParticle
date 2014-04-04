package systems.particle;
import kha.Color;
import kha.Image;
import kha.math.Vector2;
import kha.Painter;
import haxe.ds.Vector;
import kha.Rotation;
import systems.particle.Particle;
 
import util.Time;
/**
 * ...
 * @author Sidar Talei
 */

enum EmitterType {
	BOX;
	RADIAL;
}

 typedef ParticleModifier = Particle-> Void;

class ParticleSystem
{
	
	private static var particleID:Int = 0;
	

	//-------------------------------
	public var modifiers:Array<IParticleModifier>;
	public var particles:Vector<Particle>;
	
	public var pos:Vector2;
	
	//--------------------------------
	//Setup
	var activeCount:Int = 0;
	var image:Image;
	
	var running:Bool = false;
	var _paused:Bool = false;
	var rotator:Rotation;
	
	
	//---------------------------------
	//Size
	//public var startingSize:Float = 1;
	public var maxSize:Float = 1;
	public var minimumSize:Float = 0;
	//---------------------------------
	//Random
	//public var randomLife:Float = 0; // 0->1 Ranging from 0 to 1. 1 being completely random.
	//public var randomRate:Float = 0;
	//public var randomPerRate:Float = 0;
	//public var randomSize:Float = 0;// 0->1 Ranging from 0 to 1. 1 being completely random.

	public var maxParticles:Int;

	
	//---------------------------------
	//Emitter
	var emitter:IEmitter;
	
	//-----------------------------------
	//
	var color:Color;
	
	public function new(maxParticles:Int, image:Image)  
	{
		particles = new Vector<Particle>(maxParticles);
		this.maxParticles = maxParticles;
		modifiers = new Array <IParticleModifier>();
		this.image = image;
		rotator = new Rotation(new Vector2(), 0);
	
		
		pos = new Vector2();
	}
	
	public function update() : Void
	{
		
		if (!running || _paused) return;
		//-----------------------------
		//Update emitter
		var p:Particle;
		
		emitter.update(Time.deltaTime);
		var i:Int = 0;
		while (i < activeCount) {
			
			p = particles[i];
			
			p.lifeTime += Time.deltaTime;
			
			if (p.lifeTime > p.life) {
				deactivateParticle(i);
				continue; //Dont i++;
			}
			
			//Apply modifiers
			for (i in 0...modifiers.length) modifiers[i].processParticle(p);
			emitter.processParticle(p);
			
			p.x += p.vX * Time.deltaTime;
			p.y += p.vY * Time.deltaTime;
			p.rotation += p.rotationVel *  Time.deltaTime;
			
			i++;
		}
	}
	
	/**
	 * Calls the emitter to emit the given amount of particles 
	 * @param	n amount of particles to emit
	 */
	public function emit(n:Int) : Void
	{
		if (emitter != null) emitter.emit(n);
	}
	
	public function clear() : Void { while (modifiers.length != 0) modifiers.pop(); }
	
	public function start() : Void
	{
		running = true;
		_paused = false;
	}
	
	public function stop() : Void
	{
		running = false;
		activeCount = 0;
	}
	public function pause() : Void
	{
		_paused  = !_paused;
	}
	
	public function addModifier(m:IParticleModifier):Void 
	{
		modifiers.push(m);
	}
	
	public function render(painter:Painter) : Void
	{
		if (!running) return;
		//-------------------------------
		//Render particles:
		
		var p:Particle;
		for (i in 0...activeCount)
		{
			
			p = particles[i];
			rotator.angle = p.rotation;
			rotator.center.x = image.width* p.scale/2;
			rotator.center.y = image.height* p.scale/2;
			
			//if(p.color != null)painter.setColor(p.color);
			painter.setColor(p.color);
			
			painter.opacity = p.alpha;
			
			painter.drawImage2(
			image,
			emitter.imgSource.x,
			emitter.imgSource.y,
			image.width,
			image.height, 
			p.x - rotator.center.x, 
			p.y - rotator.center.y, 
			image.width * p.scale,
			image.height * p.scale,
			rotator
			);
			
			
		}
		
		painter.opacity = 1;
	}

	
	public function activateParticle() : Particle
	{
		if (activeCount + 1 > maxParticles) return null;
		
		var p:Particle = particles[activeCount];
		if (p == null) {
			particles[activeCount] = p = new Particle();
			p.id = particleID++;
		}
		
		activeCount++;
		p.lifeTime = 0;
		
		return p;
	}
	
	private function deactivateParticle(i:Int) : Void
	{
		if (activeCount <= 0) return;
		
		var temp:Particle = particles[i];
		var p:Particle = particles[activeCount - 1];
		
		particles[i]=p;
		particles[activeCount - 1] = temp;
		activeCount--;
		
		//onParticleDeath(temp);
		
	}
	
	public function setEmitter(e:IEmitter) : Void
	{
		emitter = e;
		e.setSystem(this);
	}
	
	
	function get_x():Float 
	{
		return pos.x;
	}
	
	function set_x(value:Float):Float 
	{
		if (emitter != null) emitter.x = value;
		return pos.x = value;
	}
	
	public var x(get_x, set_x):Float;
	
	function get_y():Float 
	{
		return pos.y;
	}
	
	function set_y(value:Float):Float 
	{
		if (emitter != null) emitter.y =  value;
		return pos.y = value;
	}
	
	public var y(get_y, set_y):Float;
	
	function get_isPaused():Bool 
	{
		return _paused;
	}
	
	function get_activeParticles():Int
	{
		return activeCount;
	}
	
	public var isPaused(get_isPaused, null):Bool;
	public var activeParticles(get_activeParticles, null):Int;
 
	
}


