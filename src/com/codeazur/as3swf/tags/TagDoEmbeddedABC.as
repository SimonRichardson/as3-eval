package com.codeazur.as3swf.tags
{
	import com.codeazur.as3swf.SWFData;
	import flash.utils.ByteArray;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class TagDoEmbeddedABC implements ITag
	{
		public static const TYPE:uint = 72;

		protected var _bytes:ByteArray;

		public function TagDoEmbeddedABC() {
			_bytes = new ByteArray();
		}

		public static function create(abcData:ByteArray = null):TagDoEmbeddedABC {
			var doABC:TagDoEmbeddedABC = new TagDoEmbeddedABC();
			if (abcData != null && abcData.length > 0) {
				doABC.bytes.writeBytes(abcData);
			}
			return doABC;
		}

		public function get bytes():ByteArray { return _bytes; }

		public function parse(data:SWFData, length:uint, version:uint, async:Boolean = false):void {
			var pos:uint = data.position;
			data.readBytes(bytes, 0, length - (data.position - pos));
		}

		public function publish(data:SWFData, version:uint):void {
			var body:SWFData = new SWFData();
			if (_bytes.length > 0) {
				body.writeBytes(_bytes);
			}
			data.writeTagHeader(type, body.length);
			data.writeBytes(body);
		}

		public function get type():uint { return TYPE; }
		public function get name():String { return "DoABC"; }
		public function get version():uint { return 9; }
		public function get level():uint { return 1; }

		public function toString(indent:uint = 0):String {
			return Tag.toStringCommon(type, name, indent) +
				"Length: " + _bytes.length;
		}
	}
}