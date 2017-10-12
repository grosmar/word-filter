package;
import coconut.ui.View;
import js.Browser.*;

/**
 * ...
 * @author duke
 */
class WordFilterView extends View<{model:WordFilterModel}>
{

	function render() '
	<div>
		Filter: <input oninput={model.filter=event.target.value} value={model.filter} style="width: 250px;"/>  <br/>
		Fix char: <input oninput={model.fixChar=event.target.value} value={model.fixChar} style="width: 50px;"/>
		<input type="checkbox" onchange={model.beginning = event.target.checked} checked={model.beginning} /> Beginning 
		<input type="checkbox" onchange={model.middle = event.target.checked} checked={model.middle}  /> Middle
		<input type="checkbox" onchange={model.end = event.target.checked} checked={model.end}  /> End<br/>
		Min: <input id="min" oninput={model.min=Std.parseInt(event.target.value) <= model.max ? Std.parseInt(event.target.value) : model.max} value={Std.string(model.min)} style="width: 50px;" /> 
		Max: <input id="max" oninput={model.max=Std.parseInt(event.target.value) >= model.min ? Std.parseInt(event.target.value) : model.min} value={Std.string(model.max)} style="width: 50px;" />  
		<button onclick={copy()}>Copy to clipboard</button>
		<div>
			<textarea id="wordList" oninput={model.wordList=cast event.target.value} style={"display:" + (model.showWordList ? "block" : "none") + "; float:left; width:49%; height: 500px; margin: 5px"}>{model.wordList}</textarea>
			<div id="filteredWordList" style="float:left; width:49%; margin: 5px; border: 1px solid black; min-height: 200px">
				<for {i in model.filteredList}>
					<div>{i}</div>
				</for>
			</div>
		</div>
		<div style="clear:both"></div>
		Results: {model.filteredList.length}<br/>
		<button onclick={model.showWordList = !model.showWordList}>{model.showWordList ? "Hide" : "Show" } original WordList</button>
	</div>
	';
	
	function copy()
	{
		var range = document.createRange();
		range.selectNode(document.getElementById("filteredWordList"));
		window.getSelection().addRange(range);
		document.execCommand("Copy");
		window.getSelection().removeAllRanges();
	}
	
}