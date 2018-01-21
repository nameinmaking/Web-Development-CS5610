var text1 = [];
text1[0] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed varius a enim id maximus. Duis mi erat, ultrices a massa non, pretium egestas quam. Nulla interdum scelerisque diam, nec pretium velit pulvinar eu. Quisque egestas quam et imperdiet lobortis. Curabitur et turpis quam. Fusce enim eros, scelerisque a dictum sit amet, euismod non diam. Maecenas non elit eget sapien euismod scelerisque. Nunc ut ornare quam. Etiam laoreet risus vitae laoreet egestas. Aliquam erat volutpat. Nulla lobortis, metus eget mattis varius, mauris tortor ultricies lectus, sed vestibulum nulla est ultricies lectus.";
text1[1] = "Donec erat odio, tempor sit amet molestie ut, porta id nibh. Aliquam mattis maximus rutrum. Vestibulum eu lobortis enim. Cras feugiat imperdiet turpis quis scelerisque. Integer blandit nibh at nibh commodo mollis. Sed faucibus velit eget ex faucibus condimentum. Morbi sit amet turpis ex. Nunc commodo, neque vel molestie scelerisque, metus nisl rhoncus nisi, ut feugiat nibh nisi nec sapien. Curabitur euismod a dolor et egestas. Maecenas ac massa a metus imperdiet vehicula. Vestibulum semper congue quam, id sollicitudin enim commodo et. Vestibulum semper congue enim, nec ullamcorper dolor cursus ut. Phasellus et molestie lorem.";
text1[2] = "Etiam aliquam quis dolor nec imperdiet. Donec eget porta arcu, quis tempor nibh. Fusce consectetur lectus non condimentum blandit. Integer vitae finibus nisl. Proin a scelerisque diam, et ullamcorper magna. Morbi non leo aliquam, laoreet nisi vel, condimentum enim. Nulla facilisi. Nunc vitae mattis est. Nulla tempus leo vel porttitor maximus. Maecenas iaculis leo nec urna dapibus, nec lobortis nisl consequat. Vestibulum luctus enim in viverra rhoncus. Aliquam malesuada nisl lacus.";
text1[3] = "Vestibulum at libero at ex sagittis porta. Quisque nisi leo, condimentum nec eros sed, finibus malesuada eros. Donec eu dignissim lorem. In auctor pharetra augue in ullamcorper. Nam ultricies dictum quam, eu commodo justo pellentesque eget. Donec ut ipsum risus. Cras sagittis dapibus dolor. Quisque viverra diam magna, eu malesuada sem feugiat sed. Etiam pulvinar tellus eu tellus malesuada efficitur. Morbi quis nibh vitae libero maximus molestie eget et est. Nullam eget sagittis nisl.";
var text21 = " bottles of beer on the wall, ";
var text22 = " bottles of beer. Take one down, pass it around, ";
var text23 = "  bottles of beer on the wall..."
var text3 = "this is the third thing";

var para;
var node;
var element = document.getElementById("rightDiv");
var i;
lorem();

function lorem()
{
	document.getElementById("rightDiv").innerHTML = "";

	for (i=0;i<4;i++)
	{
		para = document.createElement("p");
		node = document.createTextNode(text1[i]);
		para.appendChild(node);
		element.appendChild(para);
	}
}

function bottles()
{
	document.getElementById("rightDiv").innerHTML = "";
	var tmp;
	for (i=99;i>=96;i--)
	{
		tmp = i + text21 + i + text22 + (i-1) + text23;
		para = document.createElement("p");
		node = document.createTextNode(tmp);
		para.appendChild(node);
		element.appendChild(para);
	}
}

function lastThings()
{
	document.getElementById("rightDiv").innerHTML = "";

	para = document.createElement("p");
	node = document.createTextNode(text3);
	para.appendChild(node);
	element.appendChild(para);
}