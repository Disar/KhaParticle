package systems.particle.modifiers;
import systems.particle.IParticleModifier;
import systems.particle.Particle;

/**
 * ...
 * @author Sidar Talei
 */
class RotationModifier implements IParticleModifier
{

	public function new() 
	{
		
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void 
	{
		p.rotation = Math.atan2(p.vY, p.vX);
	}
	
}