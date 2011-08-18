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
package com.apple.reshacker.file
{
	import flash.utils.ByteArray;
	public class Header
	{
		private var _data : ByteArray;
		public function Header() {
			
		}

		public function init(ba : ByteArray) : void
		{
			_data = new ByteArray();
			for(var i:uint = 0; i!=256; i++)
				_data.writeByte(ba.readByte());
		}

		public function get data() : ByteArray
		{
			return _data;
		}
	}
}
