package uhx.macro.impl;

/**
 * ...
 * @author Skial Bainn
 */
@:multiType(T) abstract Slicer<T>(ISlicer<T>) {

	public function new(v:T);
	
	public inline function slice(start:Int, end:Int) return this.slice(start, end);
	
	@:to public static inline function asString<T:String>(s:ISlicer<T>, v:T) {
		return new StringSlicer(v);
	}
	
	@:to public static inline function asAnyArray<T:Array<Dynamic>>(s:ISlicer<T>, v:T) {
		return new ArraySlicer<Dynamic>(v);
	}
	
}

private interface ISlicer<T> {
	public function slice(start:Int, end:Int):T;
}

private class StringSlicer implements ISlicer<String> {
	public var value:String;
	public inline function new(value:String) {
		this.value = value;
	}
	
	public inline function slice(start:Int, end:Int):String {
		return value.substring(start, end);
	}
}

private class ArraySlicer<T> implements ISlicer<Array<T>> {
	public var value:Array<T>;
	public inline function new(value:Array<T>) {
		this.value = value;
	}
	
	public inline function slice(start:Int, end:Int):Array<T> {
		return value.slice(start, end);
	}
}