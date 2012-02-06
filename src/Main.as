package
{
	import org.osflash.eval.ActionScriptEvaluator;
	import org.osflash.eval.getDefinition;
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class Main extends Sprite
	{

		private var _eval : ActionScriptEvaluator;

		public function Main()
		{
			super();
			
			_eval = new ActionScriptEvaluator();
			_eval.onSuccess.addOnce(handleSuccess);
			_eval.load(loadContents());
		}
		
		private function loadContents() : String
		{
			var contents : String;
			
			const fileStream : FileStream = new FileStream();
			try
			{
				const file : File = File.applicationDirectory.resolvePath('Movie.as');
				fileStream.open(file, FileMode.READ);
				contents = fileStream.readMultiByte(file.size, File.systemCharset);
			}
			catch(error : Error) { contents = null; }
			finally { fileStream.close(); } 
				
			return contents; 
		}
		
		private function handleSuccess() : void
		{
			const definition : Class = getDefinition('Movie');
			if(null != definition) addChild(new definition());
		}
	}
}
