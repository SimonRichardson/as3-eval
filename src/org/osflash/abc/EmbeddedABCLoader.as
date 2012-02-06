package org.osflash.abc
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.tags.TagDoEmbeddedABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import org.osflash.abc.providers.IABCProvider;



	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class EmbeddedABCLoader extends AbstractABCLoader
	{

		private var _provider : IABCProvider;

		public function EmbeddedABCLoader(provider : IABCProvider, domain : ApplicationDomain = null)
		{
			super(domain);

			if (null == provider)
				throw new ArgumentError('Provider can not be null');

			_provider = provider;
		}

		public function load() : void
		{
			const binaries : Vector.<ByteArray> = _provider.getData();

			if (null == binaries)
				throw new IllegalOperationError('Binaries can not be null');
			if (binaries.length < 1)
				throw new IllegalOperationError('Binaries must not be empty');
			
			const total : int = binaries.length;
			for (var i : int = 0; i < total; i++)
			{
				const byteArray : ByteArray = binaries[i];
				byteArray.position = 0;
				
				swf.tags.push(TagDoEmbeddedABC.create(byteArray));
			}
			
			swf.tags.push(new TagShowFrame());
			swf.tags.push(new TagEnd());

			loadBytes(new SWFData());
		}
	}
}
