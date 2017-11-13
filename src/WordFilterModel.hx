package;
import coconut.data.Model;
import tink.pure.List;

/**
 * ...
 * @author duke
 */
class WordFilterModel implements Model
{

	@:editable var wordList:String;
	
	@:editable var filter:String;
	
	@:editable var fixChar:String;
	
	@:editable var min:UInt;
	
	@:editable var max:UInt;
	
	@:editable var beginning:Bool = @byDefault true;
	
	@:editable var middle:Bool = @byDefault true;
	
	@:editable var end:Bool = @byDefault true;
	
	@:editable var showWordList:Bool = @byDefault false;
	
	@:computed var filteredList:List<String> = searchAnywhere( wordList, fixChar, filter, min, max );
	
	
	function searchAnywhere( s:String, fixed:String, others:String, minLength:Int, maxLength:Int ):List<String>
	{
		
		
		var matches:Array<String> = [];
		
		var r:EReg;
		
		if ( fixed != null && fixed != "")
		{
			/*r = new EReg("\n(" + fixed + "[" + others + "]{" + (minLength - 1) + "," + (maxLength - 1) + "})\n", "gu");
			matches = matches.concat( map(r, s) );
			
			r = new EReg("\n([" + others + "]{" + (minLength - 1) + "," + (maxLength - 1) + "}" + fixed + ")\n", "gu");
			matches = matches.concat( map(r, s) );*/
			
			var begMatch = (beginning ? "(?:" + fixed + "[" + others + "]{1," + (maxLength - 1) + "})" : null);
			var endMatch = (end ? "(?:[" + others + "]{1," + (maxLength - 1) + "}" + fixed + ")" : null);
			var midMatch = (middle ? "(?:[" + others + "]{1," + (maxLength - 1) + "}" + fixed + "[" + others + "]{1," + (maxLength - 1) + "})" : null);
			
			var matchArr = [];
			if ( begMatch != null )
				matchArr.push( begMatch );
			if ( endMatch != null )
				matchArr.push( endMatch );
			if ( midMatch != null )
				matchArr.push( midMatch );
			
			r = new EReg("^(" + matchArr.join("|") + ")$", "gmu");
			
			matches = map(r, s);
			matches = matches.filter( function(s) return s.length >= minLength && s.length <= maxLength );
		}
		else
		{
			r = new EReg("\n([" + others + "]{" + (minLength) + "," + (maxLength) + "})\n", "gu");
			matches = map(r, s);
		}
		
		return List.fromArray(matches);
		
	}
	
	function map( r:EReg, s:String ):Array<String>
	{
		var matches:Array<String> = [];
		
		r.map( s, function(r) {
			var match = r.matched(0);
			
			matches.push(match);
			
			return match;
		});
		
		return matches;
	}
	
}