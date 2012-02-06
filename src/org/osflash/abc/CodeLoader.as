package org.osflash.abc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import org.osflash.esc.compileStringToBytes;



	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class CodeLoader extends AbstractABCLoader
	{

		private static const PREFIX : String = 'ABCCode';

		private var _name : String;

		public function CodeLoader(name : String = '', domain : ApplicationDomain = null)
		{
			super(domain);

			_name = (null == name || name.length < 1) ? PREFIX + getTimer() : name;
		}

		public function load(value : String, instantiate : Boolean = false, lazy : Boolean = false) : void
		{
			if (null == value)
				throw new IllegalOperationError('String can not be null');
			if (value.length < 1)
				throw new IllegalOperationError('String must not be empty');

			const abc : ByteArray = compileStringToBytes(value, name + '.as');
			swf.tags.push(TagDoABC.create(abc, '', lazy));
			
			if(instantiate)
			{
				const symbol : TagSymbolClass = new TagSymbolClass();
	            symbol.symbols.push(SWFSymbol.create(0, name));
	            swf.tags.push(symbol);
			}
						
			swf.tags.push(new TagShowFrame());
			swf.tags.push(new TagEnd());

			loadBytes(new SWFData());
		}

		public function get name() : String { return _name; }
	}
}
