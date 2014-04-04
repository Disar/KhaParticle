package systems.particle.modifiers;

import systems.particle.IParticleModifier;
import systems.particle.Particle;
import util.Normalize;


enum ColorTransition {
	NORMAL;
	REVERSE;
}

/**
 * ...
 * @author Sidar Talei
 */
class ColorModifier implements IParticleModifier
{

	
	/*private static function interpolateColor(c1:Color, c2:Color, t:Float ) : Color
	{
		var cA:Int = Std.int(c1.Ab + (c2.Ab - c1.Ab) * t);
		var cR:Int = Std.int(c1.Rb + (c2.Rb - c1.Rb) * t);
		var cG:Int = Std.int(c1.Gb + (c2.Gb - c1.Gb) * t);
		var cB:Int = Std.int(c1.Bb + (c2.Bb - c1.Bb) * t);
	
		var value:Int =  (cA << 24) | (cR << 16) | (cG << 8) | cB;
		
		return Color.fromValue(value);
	}*/
	
	private static function  interpolateColorsCompact(a:Int, b:Int, t:Float):Int
	{ 
	   var MASK1:Int = 0xff00ff; 
	   var MASK2:Int = 0x00ff00; 

	   var f2:Int = Std.int(256 * t);
	   var f1:Int = 256 - f2;

	   var c:Int =   ((((( a & MASK1 ) * f1 ) + ( ( b & MASK1 ) * f2 )) >> 8 ) & MASK1 ) 
			  | ((((( a & MASK2 ) * f1 ) + ( ( b & MASK2 ) * f2 )) >> 8 ) & MASK2 );
		
		return c;

	} 
	
	private var colors:Array<Int>;
	private var positions:Array<Float>;
	
	private var ratio:Float = 0;
	private var startColor:Int;
	private var endColor:Int;
	private var startPos:Float;
	private var endPos:Float;
	
	public var transition:ColorTransition;
	
	public function new(?transition:ColorTransition) 
	{
		colors = new Array<Int>();
		positions = new Array<Float>();
		transition == null ?  (this.transition = ColorTransition.NORMAL):(this.transition = transition);
	}
	
	public function pushColor(c:Int, t:Float) : Void
	{
		colors.push(c);
		positions.push(t);
	}
	
	public function popColor() : Void
	{
		colors.pop();
		positions.pop();
	}
	
	/* INTERFACE systems.particle.IParticleModifier */
	
	public function processParticle(p:Particle):Void 
	{
		ratio = (p.lifeTime / p.life);
		
		for (i in 0...colors.length-1)
		{
			if (ratio >= positions[i] &&  ratio <= positions[i + 1])
			{
				startColor = colors[i];
				endColor = colors[i + 1];
				startPos = positions[i];
				endPos = positions[i+1];
				break;
			}
		}
		
		p.color.value = interpolateColorsCompact(
			startColor,
			endColor,
			Normalize.normalize(startPos, endPos, ratio)
		);
	}
	
}