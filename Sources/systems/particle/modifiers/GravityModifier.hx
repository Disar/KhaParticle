package systems.particle.modifiers;
import kha.math.Vector2;
import kha.Scheduler;
import systems.particle.Particle;

/**
 * ...
 * @author Sidar Talei
 */
class GravityModifier implements IParticleModifier
{    
	public var gravity:Vector2;
	
	
	public function new(gx:Float, gy:Float) 
	{
		
		gravity = new Vector2(gx, gy);
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void 
	{
		p.vX += gravity.x * Scheduler.deltaTime;
		p.vY += gravity.y * Scheduler.deltaTime;
	}
	
}