package
{
	import flash.utils.getDefinitionByName;
	import org.osflash.eval.ActionScriptEvaluator;

	import flash.display.Sprite;

	public class Main extends Sprite
	{

		private static const code : String = "" 
			+ "use namespace 'flash.display';\n"
			+ "\n"
			+ "class Movie extends Sprite {\n"
			+ "\n"
			+ "    public function Movie() {\n" 
			+ "        // write es4 code here..\n" 
			+ "        for(var i : int = 0; i < 100; i++) {\n"
			+ "           var col : int = Math.random() * 0xffffff;\n"
			+ "           graphics.beginFill(col, (Math.random() * 0.8) + 0.2);\n" 
			+ "           graphics.drawCircle(Math.random() * 400, Math.random() * 400, (Math.random() * 40) + 20);\n"
			+ "			}\n"
			+ "    }\n" 
			+ "\n" 
			+ "}";
			
		private var _eval : ActionScriptEvaluator;

		public function Main()
		{
			super();
			
			_eval = new ActionScriptEvaluator();
			_eval.onSuccess.addOnce(handleSuccess);
			_eval.load(code);
		}
		
		private function handleSuccess() : void
		{
			addChild(new (getDefinitionByName('Movie') as Class)());
		}
	}
}
