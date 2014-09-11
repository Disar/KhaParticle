package systems.particle;
import kha.Color;
import kha.math.Vector2;
import kha.Rotation;

/**
 * ...
 * @author Sidar Talei
 */
class Particle {
	public function new() { }
	public var id:Int = 0;
	public var scale:Float = 1;
	public var alpha:Float = 1;
	public var vX:Float = 0;
	public var vY:Float = 0;
	public var x:Float = 0;
	public var y:Float = 0;
	public var sx:Float = 0;
	public var sy:Float = 0;
	public var life:Float = 1;
	public var lifeTime:Float = 0;
	public var rotation:Float = 0;
	public var rotationVel:Float = 0;
	public var color:Null<Color>;
}