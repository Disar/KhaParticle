package util;

/**
 * ...
 * @author Sidar Talei
 */
class Normalize
{

	/**
	 * Normalizes a value between 0 and 1;
	 * @param	min Minimum value
	 * @param	max Maximum value
	 * @param	value The value that needs to be normalized
	 * @return
	 */
	public static function normalize(min:Float, max:Float, value:Float) : Float
	{
		var n:Float = (value - min) / (max - min);
		n = n > 1 ? 1:n;
		n = n < 0 ? 0:n;
		return n;
	}
}