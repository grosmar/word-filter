package;

import haxe.Resource;
import js.Browser;
import js.Browser;
import vdom.VDom.*;
import view.*;
import coconut.Ui.hxx;


/**
 * ...
 * @author duke
 */
class Main 
{
	
	static function main() 
	{
		var s = Resource.getString("wordlist");
		
		var savedFilter:String = "";
		var savedFixChar:String = "";
		var savedMin:UInt = 3;
		var savedMax:UInt = 5;
		 
		
		try
		{
			var ls = Browser.getLocalStorage();
			savedFilter = ls.getItem("filter") != null && ls.getItem("filter") != "" ? ls.getItem("filter") : "aácdeéfhiíoóöőõjklmnpstuúvzsz";
			savedFixChar = ls.getItem("fixChar") != null ? ls.getItem("fixChar") : savedFixChar;
			savedMin = ls.getItem("min") != null ? Std.parseInt(ls.getItem("min")) : savedMin;
			savedMax = ls.getItem("max") != null ? Std.parseInt(ls.getItem("max")) : savedMax;
		}
		
		var model = new WordFilterModel({wordList:s, filter:savedFilter, fixChar: savedFixChar, min:savedMin, max:savedMax});
		
		var root = hxx('<WordFilterView model={model} />');
		Browser.document.body.appendChild( root.toElement() );
		
		Browser.window.onunload = function ()
		{
			Browser.getLocalStorage().setItem("filter", model.filter);
			Browser.getLocalStorage().setItem("fixCha", model.fixChar);
			Browser.getLocalStorage().setItem("min", Std.string(model.min));
			Browser.getLocalStorage().setItem("max", Std.string(model.max));
		}
	}
	
}