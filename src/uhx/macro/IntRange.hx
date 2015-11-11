package uhx.macro;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

using Std;
using haxe.macro.ExprTools;

/**
 * ...
 * @author Skial Bainn
 */
class IntRange {

	public static function build():Array<Field> {
		var fields = Context.getBuildFields();
		
		for (field in fields) switch (field.kind) {
			case FFun(m):
				m.expr.iter( handler );
				
			case _:
				
		}
		
		return fields;
	}
	
	public static function handler(expr:Expr) {
		switch (expr.expr) {
			// I'm only interested in reverse for loops.
			case EFor( { expr:EIn(id, {expr:EBinop( OpInterval, { expr:EConst(CInt(start)), pos:_ }, { expr:EConst(CInt(end)), pos:_ } ), pos:_}), pos:_ }, body) if (start.parseInt() > end.parseInt()):
				expr.expr = (macro for ($id in $e { handleRangeInt( start.parseInt(), end.parseInt() ) } ) $body).expr;
				
			case EBinop( OpInterval, { expr:EConst(CInt(start)), pos:_ }, { expr:EConst(CInt(end)), pos:_ } ):
				expr.expr = handleRangeInt( start.parseInt(), end.parseInt() ).expr;
				
			case EVars( vars ): for (v in vars) if (v.expr != null) switch (v.expr.expr) {
				case EBinop( OpInterval, { expr:EConst(CInt(start)), pos:_ }, { expr:EConst(CInt(end)), pos:_ } ):
					v.expr.expr = handleRangeInt( start.parseInt(), end.parseInt() ).expr;
					
				case EArrayDecl( [ { expr:EFor(condition, body), pos:_ } ]):
					handler( condition );
					
				case _:
					//trace( v.expr );
			}
			
			case EArray(object, { expr:EBinop( OpInterval, { expr:EConst(CInt(start)), pos:_ }, { expr:EConst(CInt(end)), pos:_ } ), pos:_ } ):
				expr.expr = ( macro new uhx.macro.impl.Slicer($object).slice($v { start.parseInt() }, $v { end.parseInt() } ) ).expr;
				
			case _:
				//trace( expr );
				expr.iter( handler );
				
		}
		
	}
	
	public static function handleRangeInt(start:Int, end:Int):Expr {
		var reverse = start > end;
		var values = [];
		
		while (reverse ? start > end-1 : start < end+1) {
			values.push( start );
			reverse ? start-- : start++;
		}
		
		return macro $v{ values };
	}
	
}