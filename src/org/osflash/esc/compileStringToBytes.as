package org.osflash.esc
{
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function compileStringToBytes(	code : String, 
											label : String = '(string)',
											domain : ApplicationDomain = null
											) : ByteArray
	{
		// Get the correct application domain.
		const appDomain : ApplicationDomain = null != domain ? 
										domain : 
										ApplicationDomain.currentDomain;
		
		// Get the compile method
		var method : Function;
		try { method = appDomain.getDefinition('ESC.compileStringToBytes') as Function; }
		catch(error : Error) {}
		
		// Call the the method with a label
		return (null != method) ? method(code, label) : null;
	}
}
