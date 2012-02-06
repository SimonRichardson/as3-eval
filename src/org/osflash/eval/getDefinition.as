package org.osflash.eval
{
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getDefinition(name : String, domain : ApplicationDomain = null) : *
	{
		var definition : *;
		try
		{
			if(null == domain) definition = getDefinitionByName(name);
			else definition = domain.getDefinition(name);
		}
		catch(error : Error) { definition = null; }
		
		return definition;
	}
}
