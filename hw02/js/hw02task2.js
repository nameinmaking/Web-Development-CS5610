var number = document.getElementById("currentNumber").innerHTML;
function currentValue()
{
	alert("Value of the number: " + number);
}

function incrementValue()
{
	document.getElementById("currentNumber").innerHTML = ++number;
}

function appendParagraph()
{
	var para = document.createElement("p");
	var node = document.createTextNode(number);

	para.appendChild(node);
	var element = document.getElementById("paraText");

	element.appendChild(para);
}