package;

/**
 * ...
 * @author Skial Bainn
 */
@:build( uhx.macro.IntRange.build() )
class Main {
	
	static function main() {
		var values = 0...9;
		trace( values );
		
		values = 1...10;
		trace( values );
		
		values = 10...1;
		trace( values );
		
		values = [for (i in 0...9) i];
		trace( values );
		
		values = [for (i in 1...10) i];
		trace( values );
		
		values = [for (i in 10...1) i];
		trace( values );
		
		values = values[0...2];		// Sugar for array.slice(start, end);
		trace( values ); 	// [10, 9];
		
		var string = 'hello world';
		string = string[0...5];		// Sugar for string.substring(start, end);
		trace( string );	// 'hello';
		
		var numbers = [for (i in 1...10) i];
		trace( numbers );
		
		var numbers = [for (i in 10...1) i];
		trace( numbers );
		
		var letters = ['a', 'b', 'c', 'd', 'e', 'f'];
		letters = letters[1...4];	// ['b', 'c', 'd'];
		trace( letters );
	}
	
}