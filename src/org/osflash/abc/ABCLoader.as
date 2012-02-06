package org.osflash.abc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagShowFrame;

	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ABCLoader extends AbstractABCLoader
	{
		
		public function ABCLoader(domain : ApplicationDomain = null)
		{
			super(domain);
		}

		public function load(value : ByteArray) : void
		{
			if (null == value)
				throw new IllegalOperationError('ByteArray can not be null');
			if (value.length < 1)
				throw new IllegalOperationError('ByteArray must not be empty');
			
			swf.tags.push(TagDoABC.create(value));
			swf.tags.push(new TagShowFrame());
			swf.tags.push(new TagEnd());
						
			loadBytes(new SWFData());
		}
	}
}
