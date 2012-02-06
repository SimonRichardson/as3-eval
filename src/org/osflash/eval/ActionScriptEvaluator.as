package org.osflash.eval
{
	import org.osflash.abc.CodeLoader;
	import org.osflash.abc.EmbeddedABCLoader;
	import org.osflash.abc.providers.EmbeddedABCLoaderProvider;
	import org.osflash.abc.providers.IABCProvider;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.system.ApplicationDomain;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ActionScriptEvaluator
	{
		
		private const _failure : ISignal = new Signal();
		
		private const _success : ISignal = new Signal();
		
		private var _code : String;
		
		private var _domain : ApplicationDomain;

		private var _abcLoader : EmbeddedABCLoader;

		private var _codeLoader : CodeLoader;
		
		private var _loading : Boolean;

		public function ActionScriptEvaluator(	domain : ApplicationDomain = null, 
												abcProvider : IABCProvider = null
												)
		{
			_domain = null != domain ? domain : ApplicationDomain.currentDomain;

			_codeLoader = new CodeLoader('', _domain);
			_codeLoader.onSuccess.add(handleEvaluatedCode);

			const provider : IABCProvider = null != provider ? 
													provider : 
													new EmbeddedABCLoaderProvider();
			_abcLoader = new EmbeddedABCLoader(provider);
			_abcLoader.onFailure.addOnce(handleFailure);
			_abcLoader.onSuccess.addOnce(handleLoadedABC);
		}

		public function load(code : String) : void
		{
			if(isLoading) throw new IllegalOperationError('Evaluator is currently loading');
			
			if(null == code) throw new ArgumentError('Code can not be null');
			if(code.length < 1) throw new ArgumentError('Code can not be empty');
			
			_code = code;
			_loading = true;
			
			if (compilerLoaded)
				_codeLoader.load(code, false, true);
			else
			{
				_abcLoader.load();
			}
		}
		
		private function cleanUp() : void
		{
			_loading = false;
		}
		
		private function handleLoadedABC() : void
		{
			_codeLoader.load(code, false, true);
		}

		private function handleEvaluatedCode() : void
		{
			cleanUp();
			
			onSuccess.dispatch();
		}
		
		private function handleFailure() : void
		{
			cleanUp();
			
			onFailure.dispatch();
		}
		
		public function get code() : String { return _code; }
		public function get domain() : ApplicationDomain { return _domain; }
		public function get loader() : Loader { return _codeLoader.loader; }
		public function get isLoading() : Boolean { return _loading; }
		
		public function get onFailure() : ISignal { return _failure; }
		public function get onSuccess() : ISignal { return _success; }

		private function get compilerLoaded() : Boolean
		{
			// Locate the compile method
			var success : Boolean = true;
			var method : Function;
			try
			{
				method = domain.getDefinition('ESC.compileStringToBytes') as Function;
			}
			catch(error : Error)
			{
				success = false;
			}
			return success && null != method;
		}
	}
}
