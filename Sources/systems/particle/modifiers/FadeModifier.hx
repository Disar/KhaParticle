package systems.particle.modifiers;

import systems.particle.IParticleModifier;
import systems.particle.Particle;

enum FadeType {
	FADE_IN;
	FADE_OUT;
	FADE_IN_OUT;
	FADE_OUT_IN;
}

/**
 * ...
 * @author Sidar Talei
 */
class FadeModifier implements IParticleModifier {

	public var type:FadeType;
	
	public function new(ft:FadeType) {
		 
		type = ft;
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void {
		switch(type){
			case FadeType.FADE_IN:
				p.alpha = p.lifeTime / p.life;
			case FadeType.FADE_OUT:
				p.alpha = 1 - p.lifeTime / p.life;
			case FadeType.FADE_IN_OUT:
				if (p.lifeTime / p.life <= .5)
				p.alpha = p.lifeTime / p.life;
				else
				p.alpha = 1 - p.lifeTime / p.life;
			case FadeType.FADE_OUT_IN:
				if (p.lifeTime / p.life >= .5)
				p.alpha = p.lifeTime / p.life;
				else
				p.alpha = 1 - p.lifeTime / p.life;
		}
	}
}