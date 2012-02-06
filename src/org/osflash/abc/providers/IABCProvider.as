package org.osflash.abc.providers
{
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IABCProvider
	{
		
		function getData() : Vector.<ByteArray>;
	}
}
