package systems.particle;
import haxe.ds.Vector.Vector;
import kha.Animation;
import kha.Color;
import kha.Configuration;
import kha.math.Random;
import kha.math.Vector2;
import kha.Scene;

/**
 * ...
 * @author Sidar Talei
 */


 
class IEmitter{
	
	/** Emission rate*/
	public var rate:Float;
	/** Emission time in seconds*/
	public var duration:Float;
	/** Particle velocity*/
	public var speed:Float;
	/** The amount of partciles spawned at once*/
	public var amountPerRate:Int = 1;
	/** Emission start point on the x axis*/
	public var x:Float;
	/** Emission start point on the y axis*/
	public var y:Float;
	/** Starting scale of a particle*/
	public var startScale:Float = 1;
	/** Rotation speed*/
	public var maxRotationVel:Float = 0;
	/**
	 * Randomness between maxRotation
	 * Between 0 and 1;
	 * */
	public var rotationVariation:Float = 1;//[-1 - 1];
	/**maximum life time a particle will have in seconds*/
	public var maxLife:Float; 
	/**
	 * Randomness between max life
	 * Between 0 and 1;
	 * */
	public var lifeVariation:Float = 0; // [0-1]
	/**
	 * Starting point of the particles life time
	 * Between 0 and 1;
	 * */
	public var lifeOffset:Float = 0;
	/**
	 * varation of the starting point of life time
	 * Between 0 and 1;
	 * */
	public var lifeOffsetVariation:Float = 0;
	/**
	* Whether emission should continue after
	* time has exceeded the duration.
	* 
	* If set to false emission will only occurred
	* during duration time.
	* 
	* */
	public var loop:Bool = false;
	/**
	* The coordinates of the image source
	* */
	public var imgSource:Vector2;
	/**
	* Indicates whether this is a subEmitter.
	* Handled by Particle System, do not manually
	* change.
	* */
	public var isSubEmitter:Bool = false;
	//public var maxScale:Float = 1; // [0-1]
	//public var scaleVariation:Float = .5; // [0-1]
	//----------------------------------------
	
	/** particle system handling this emitter*/
	private var system:ParticleSystem;
	/** Time counter for emission*/
	private var counter:Float = 0;
	/**Time counter for current duration*/
	private var durationCount:Float = 0;
	/**Array for burst properties */
	private var burstArray:Array<BurstProp>;
	
	
	private function new() { 
		imgSource  = new Vector2();
		burstArray = new Array<BurstProp>();
	}
	
	public function update(dt:Float) : Void {
		updateEmission(dt);
	}
	
	public function setSystem(ps:ParticleSystem) : Void {
		system = ps;
	}
	
	public function addBurst(b:BurstProp) : Void{
		burstArray.push(b);
	}
	
	private function updateEmission(dt:Float) : Void {
		
		durationCount += dt;
		
		if (durationCount > duration){
			if (!loop) return;
			else durationCount = 0;
		}
		
		//Update bursts
		for (i in 0...burstArray.length){
			burstArray[i].timeCounter += dt;
			if (burstArray[i].timeCounter > burstArray[i].time)
			{
				emit(burstArray[i].amount);
				burstArray[i].timeCounter = 0;
			}
			
		}
		
		if (rate < 1) return;
		
		var pAmount:Int = 1;
		var ratio:Float = 1 / rate;
		var catchUp:Float = 0;
		//var fps:Float = 1 / Time.deltaTime;
		
		counter += dt;
 
	
		if (counter > ratio) {

			//Fix catching up?
			catchUp = dt / ratio;
			
			pAmount = amountPerRate;
			pAmount += Math.floor(catchUp);
			
			//if (isSubEmitter)
			//system.handleSubEmission(pAmount);
			//else
			emit(pAmount);
			counter = 0;
			
		}
		

		//calc time.
		
	}
	
	public function emit(amount:Int) : Void {
		var p:Particle;
		for (j in 0...amount) {
			p = system.activateParticle();
			if (p != null) onParticleActivate(p);
		}
	}
	
	private function onParticleActivate(p:Particle) : Void {
		
		//TODO FIX
		//p.scale = maxScale *  1 - (Math.random() * scaleVariation);
		p.life = maxLife *  (1 - (Math.random() * lifeVariation));
		p.lifeTime += (lifeOffset * (1 - (Math.random() * lifeOffsetVariation))) * p.life;
		p.alpha = 1;
		p.rotationVel = maxRotationVel * (1 - (Math.random() * rotationVariation));
		p.sx = x;
		p.sy = y;
		p.scale = startScale;
		
		//p.color = Color.fromBytes(Std.int(Math.random() * 256), Std.int(Math.random() * 256), Std.int(Math.random() * 256));
		p.color = Color.fromValue(0xFFFFFFFF);
	}
	
	public function processParticle(p:Particle) : Void {}
	
}

class BurstProp {
	public function new() {}
	
	public var amount:Int = 0;
	public var time:Float = 0;
	public var timeCounter:Float = 0;
	
}