package systems.particle.modifiers;

import systems.particle.IParticleModifier;
import systems.particle.Particle;

/**
 * ...
 * @author Sidar Talei
 */
class DragModifier implements IParticleModifier
{

	public function new() 
	{
		
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void 
	{
		p.vX *= 0.98;
		p.vY *= 0.98;
	}
	
}