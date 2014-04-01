package util;
import kha.Scheduler;

/**
 * ...
 * @author Sidar Talei
 */
class Time
{

	
	private static var old:Float;
	private static var dt:Float;
	private static var _rate:Float = 1;
	
	public function new() 
	{
		
	}

	public static function update() : Void
	{
		dt = Scheduler.time() - old;
		old = Scheduler.time();
	}
	
	static function get_deltaTime():Float 
	{
		return dt * rate;
	}
	
	public static var deltaTime(get_deltaTime, null):Float;
	
	static function get_rate():Float 
	{
		return _rate;
	}
	
	static function set_rate(value:Float):Float 
	{
		return _rate = value;
	}
	
	static public var rate(get_rate, set_rate):Float;
	
}