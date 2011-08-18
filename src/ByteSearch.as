/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) 2011 - Jay Moretti <jrmoretti@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
/**
 * Knuth-Morris-Pratt Algorithm for Pattern Matching
 */
package
{
	import flash.utils.ByteArray;
	/**
	 * @author Jay Moretti
	 */
	public class ByteSearch {
		
		public static function search(s:ByteArray, p:Array):Array
		{
			var results:Array = [];
			var t:Array = [];
			var offset:Array  = [];
			s.position = 0;
			while(s.position!=s.length)
			{
				var byte:String = s.readUnsignedByte().toString(16);
				if(t.length!=p.length)
				{
					if( byte == p[t.length])
					{
						t.push(byte);
					} else {
						t = [];
						if(byte == p[t.length])
							t.push(byte);
					}
				} else {
					
					t = [];
					results.push(s.position-p.length);
				}
			}
			return results;
		}
	}
}