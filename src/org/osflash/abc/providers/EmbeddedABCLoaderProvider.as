package org.osflash.abc.providers
{
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class EmbeddedABCLoaderProvider implements IABCProvider
	{

		[Embed(source="../../../../../abc/abc.es.abc",mimeType="application/octet-stream")]
		private static var _abc : Class;

		[Embed(source="../../../../../abc/asm.es.abc",mimeType="application/octet-stream")]
		private static var _asm : Class;

		[Embed(source="../../../../../abc/ast.es.abc",mimeType="application/octet-stream")]
		private static var _ast : Class;

		[Embed(source="../../../../../abc/bytes-tamarin.es.abc",mimeType="application/octet-stream")]
		private static var _bytesTamarin : Class;

		[Embed(source="../../../../../abc/cogen.es.abc",mimeType="application/octet-stream")]
		private static var _cogen : Class;

		[Embed(source="../../../../../abc/cogen-expr.es.abc",mimeType="application/octet-stream")]
		private static var _cogenExpr : Class;

		[Embed(source="../../../../../abc/cogen-stmt.es.abc",mimeType="application/octet-stream")]
		private static var _cogenStmt : Class;

		[Embed(source="../../../../../abc/debug.es.abc",mimeType="application/octet-stream")]
		private static var _debug : Class;

		[Embed(source="../../../../../abc/define.es.abc",mimeType="application/octet-stream")]
		private static var _define : Class;

		[Embed(source="../../../../../abc/emit.es.abc",mimeType="application/octet-stream")]
		private static var _emit : Class;

		[Embed(source="../../../../../abc/esc-core.es.abc",mimeType="application/octet-stream")]
		private static var _escCore : Class;

		[Embed(source="../../../../../abc/esc-env.es.abc",mimeType="application/octet-stream")]
		private static var _escEnv : Class;

		[Embed(source="../../../../../abc/eval-support.es.abc",mimeType="application/octet-stream")]
		private static var _evalSupport : Class;

		[Embed(source="../../../../../abc/lex-char.es.abc",mimeType="application/octet-stream")]
		private static var _lexChar : Class;

		[Embed(source="../../../../../abc/lex-token.es.abc",mimeType="application/octet-stream")]
		private static var _lexToken : Class;

		[Embed(source="../../../../../abc/lex-scan.es.abc",mimeType="application/octet-stream")]
		private static var _lexScan : Class;

		[Embed(source="../../../../../abc/parse.es.abc",mimeType="application/octet-stream")]
		private static var _parse : Class;

		[Embed(source="../../../../../abc/util.es.abc",mimeType="application/octet-stream")]
		private static var _util : Class;

		[Embed(source="../../../../../abc/util-tamarin.es.abc",mimeType="application/octet-stream")]
		private static var _utilTamarin : Class;

		private const _byteArrays : Vector.<ByteArray> = new Vector.<ByteArray>();

		public function getData() : Vector.<ByteArray>
		{
			if (_byteArrays.length == 0)
			{
				_byteArrays.push(new _debug());
				_byteArrays.push(new _util());
				_byteArrays.push(new _bytesTamarin());
				_byteArrays.push(new _utilTamarin());
				_byteArrays.push(new _lexChar());
				_byteArrays.push(new _lexScan());
				_byteArrays.push(new _lexToken());
				_byteArrays.push(new _ast());
				_byteArrays.push(new _define());
				_byteArrays.push(new _parse());
				_byteArrays.push(new _asm());
				_byteArrays.push(new _abc());
				_byteArrays.push(new _emit());
				_byteArrays.push(new _cogen());
				_byteArrays.push(new _cogenStmt());
				_byteArrays.push(new _cogenExpr());
				_byteArrays.push(new _escCore());
				_byteArrays.push(new _evalSupport());
				_byteArrays.push(new _escEnv());
			}

			return _byteArrays;
		}
	}
}
