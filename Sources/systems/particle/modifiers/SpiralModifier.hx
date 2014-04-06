package systems.particle.modifiers;
import kha.math.Vector2;
import kha.Scheduler;
import systems.particle.IParticleModifier;
import systems.particle.Particle;
import systems.particle.ParticleSystem;

/**
 * ...
 * @author Sidar Talei
 */
class SpiralModifier implements IParticleModifier
{
	public var relative:Bool = false;
	public var strength:Float = 200;
	public var radialAcc:Float = -10;
	public var fixed:Bool = false;
	public var distanceBased:Bool = false;
	public var distanceMultiplier:Float = 0.1;
	private var center:Vector2;
	private var r:Vector2;
	private var v:Vector2;
	
	public function new(c:Vector2) 
	{
		center = c;
		v = new Vector2();
		r = new Vector2();
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void 
	{
	
		
		if(relative){
			v.x = p.sx - p.x;
			v.y = p.sy - p.y;
			if (v.x == 0) v.x = 0.1;
			if (v.y == 0) v.y = 0.1;
		}
		else
		{
			v.x = center.x - p.x;
			v.y = center.y - p.y;
		}
		var l:Float = v.length;
		v.normalize();
		r.x = v.x;
		r.y = v.y;
		
		
		var dt:Float = Scheduler.deltaTime;
		if (fixed) {
			
			if (relative) {
				//Broken
				p.x = p.sx +  -(r.x * radialAcc)  + (-v.y * strength) * dt   ;
				p.y = p.sy +  -(r.y * radialAcc)  + (v.x  * strength) * dt ;
				
			}
			else
			{
				p.x = center.x +  -(r.x * radialAcc)  + (-v.y * strength) * dt  ;
				p.y =  center.y + -(r.y * radialAcc)  + (v.x  * strength) * dt  ;
			}
		}
		else{
			if (distanceBased)
			{
				var m:Float = (l*distanceMultiplier);
				p.vX +=  -(r.x * radialAcc + -v.y * strength)/m  * dt ;
				p.vY +=  -(r.y * radialAcc + v.x  * strength)/m * dt   ;

			}
			else
			{
				p.vX +=  -(r.x * radialAcc  + -v.y * strength)  * dt;
				p.vY +=  -(r.y * radialAcc  + v.x  * strength)  * dt;
			}
		}
		
	}
	

}