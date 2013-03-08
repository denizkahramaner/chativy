
 // Takes in a container element id, a unique id which will name the element, the coordinates, the first name and last name of the tagged user
function Displayer(parent, id, x_coord, y_coord,width, height, first_name_input, last_name_input) {
  
  // Using DOM to create the tag's div with the user name and last name, which are paragraphs inside the div
  this.parent = document.getElementById(parent);
  var element = document.createElement("DIV");
  element.setAttribute('id',id);
  element.className = "oldTag";
  this.parent.appendChild(element);

  var first_name = document.createElement("P");
  var last_name = document.createElement("P");
  var first_name_text = document.createTextNode(first_name_input);
  var last_name_text = document.createTextNode(last_name_input);
  first_name.appendChild(first_name_text);
  last_name.appendChild(last_name_text);
  first_name.className = "tagName";
  last_name.className = "tagName";

  element.appendChild(first_name);
  element.appendChild(last_name);

  // As specified in the Tagger javascript file, here I automatically hardcode the border of the tag element as 2px
  // Amongh and Jason told me that we wouldn't be penalized for this.
  var borderWidth = 2;

  // Set important values
  element.style.left = x_coord + "px";
  element.style.top = y_coord + "px";
  element.style.height = (height-borderWidth*2) + "px";
  element.style.width = (width-borderWidth*2) + "px";

  // To handle the case when the tag is essentially a dot.
  if (height == 0)
    element.style.height = "2px";
  if (width == 0)
    element.style.width = "2px";
}



