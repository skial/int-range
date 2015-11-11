# int-range

An explorational Haxe build macro which extends Int ranges in Haxe.

## Setup

You add `@:build( uhx.macro.IntRange.build() )` to the top of
each class you intend to use the extended syntax in.

## Syntax

The syntax is as follows.

```Haxe
package ;

@:build( uhx.macro.IntRange.build() )
class Main {
	
	public static function main() {
		var values = [for (i in 10...1) i];		// Reverse iterators work.
		trace( values );	// [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
		
		values = values[0...2];		// Sugar for array.slice(start, end);
		trace( values ); 	// [10, 9];
		
		var string = 'hello world';
		string = string[0...5];		// Sugar for string.substring(start, end);
		trace( string );	// 'hello';
	}
	
}
```

## How it works

Internally, any match on `ident = 0...10` syntax will be inlined at compile time, except
for normal `for` loops, which are left alone. Reverse for loops are intercepted by this
build macro and the values inlined.

For the shorter `Array::slice` and `String::substring`, any array access which contains an
interval operator starting and ending with `Int`'s gets converted to `uhx.macro.impl.Slicer`, 
which is a `@:multiType` abstract. Basically this just redirects a lot of work to the compiler.