package org.osflash.abc
{
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.tags.TagFileAttributes;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class AbstractABCLoader
	{
		
		private const _failure : ISignal = new Signal();
		
		private const _success : ISignal = new Signal();
		
		private var _swf : SWF;

		private var _loading : Boolean;

		private var _loader : Loader;

		private var _domain : ApplicationDomain;

		private var _context : LoaderContext;

		public function AbstractABCLoader(domain : ApplicationDomain)
		{
			super();

			_swf = new SWF();
			_swf.compressed = false;
			_swf.tags.push(new TagFileAttributes());

			_loader = new Loader();

			const loaderInfo : LoaderInfo = _loader.contentLoaderInfo;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, handleProgressEvent);
			loaderInfo.addEventListener(Event.COMPLETE, handleComplete);
			loaderInfo.addEventListener(ErrorEvent.ERROR, handleError);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleError);

			_domain = null != domain ? domain : ApplicationDomain.currentDomain;
			_context = new LoaderContext(false, _domain, null);
			_context.allowCodeImport = true;
			_context.allowLoadBytesCodeExecution = true;
		}

		protected function loadBytes(data : ByteArray) : void
		{
			if (_loading)
				throw new IllegalOperationError('Can not load whilst currently loading');

			_loading = true;
			
			_swf.publish(data);
			
			_loader.loadBytes(data, context);
		}
		
		private function cleanUp() : void
		{
			// Remove the swf tags
			const i : int = _swf.tags.length;
			while (--i > 0)
			{
				_swf.tags.pop();
			}

			_loading = false;
		}

		private function handleProgressEvent(event : ProgressEvent) : void
		{
			_loader.dispatchEvent(event);

			if (event.bytesLoaded == event.bytesTotal)
			{
				setTimeout(function() : void
				{
					// Note: For some reason we need to make sure the next frame executes -
					// otherwise this swf doesn't load.
				}, 1);
			}
		}

		private function handleComplete(event : Event) : void
		{
			cleanUp();
			
			onSuccess.dispatch();
		}
		
		private function handleError(event : Event) : void
		{
			cleanUp();
			
			onFailure.dispatch();
		}
		
		final public function get isLoading() : Boolean { return _loading; }
		
		final public function get swf() : SWF { return _swf; }
		final public function get domain() : ApplicationDomain { return _domain; }
		final public function get context() : LoaderContext { return _context; }
		final public function get loader() : Loader { return _loader; }
		
		public function get onFailure() : ISignal { return _failure; }
		public function get onSuccess() : ISignal { return _success; }
	}
}
