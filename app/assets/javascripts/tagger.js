
function Tagger(parent, id, x_coordID, y_coordID,widthID, heightID) {
  this.x_coordID = x_coordID;
  this.y_coordID = y_coordID;
  this.widthID = widthID;
  this.heightID = heightID;
  this.parent = document.getElementById(parent);
  this.parent.className="container";
  var obj = this;
  this.parent.onmousedown = function(event) { 
    obj.mouseDown(event); 
  } 
  

  /* In this next line, I had to manually save the borderWidth of the element in order to access it later,
    because it is not possible to retrieve the borderWith. For example, this.element.style.borderWith returns ""
    I talked to Amongh and Jason and they told me that I would not be penalized for this in style points.
   */
  this.elementBorderWidth = 2;

  this.element = document.getElementById(id);
  this.element.style.display = "none"; // Tag is initially invisible
  document.ondragstart = function () { return false; };
}

Tagger.prototype.checkBounds = function(x,y) {
  var parentWidth =  parseInt(this.parent.offsetWidth) - 2*this.elementBorderWidth;
  var parentHeight = parseInt(this.parent.offsetHeight) - 2*this.elementBorderWidth;
  if (x < parentWidth && 
      y < parentHeight && x > 0 && y > 0) {
      return true;
    }
    else {
      return false;
    }
}


Tagger.prototype.mouseDown = function(event) { 
  // Make sure that the tagger is reset every time a new click event happens
  this.element.style.display = ""; 
  this.element.style.height = "0px";
  this.element.style.width = "0px";
  var tempx = event.pageX - this.parent.offsetLeft;
  var tempy = event.pageY - this.parent.offsetTop;
  this.pivotX = tempx;
  this.pivotY = tempy;
  if(this.checkBounds(tempx, tempy)) {
    this.xpos = tempx;
    this.ypos = tempy;
    this.element.style.left = this.xpos + "px";
    this.element.style.top = this.ypos + "px";

    var page = this; 
    this.oldMoveHandler = document.body.onmousemove; 
    document.onmousemove = function(event) { 
      page.mouseMove(event); 
    } 
    this.oldUpHandler = document.body.onmouseup; 
    document.onmouseup = function(event) { 
      page.mouseUp(event); 
    } 
  }
  this.isMouseDown = true; 
}

Tagger.prototype.mouseUp = function(event) { 
  this.isMouseDown = false; 
  document.onmousemove = this.oldMoveHandler; 
  document.onmouseup = this.oldUpHandler; 
}


Tagger.prototype.mouseMove = function(event) { 
  if (!this.isMouseDown) { 
    //this.mouseUp(event); 
    return;
  } 
  var tempx = event.pageX - this.parent.offsetLeft;
  var tempy = event.pageY - this.parent.offsetTop;

  var current_width = parseInt(this.element.offsetWidth);
  var current_height = parseInt(this.element.offsetHeight);

  var borderWidth = parseInt(this.parent.style.borderWidth);
  var parent_width  = parseInt(this.parent.offsetWidth);
  var parent_height = parseInt(this.parent.offsetHeight);


  if (tempx > parent_width ) // If the mouse is outside the container on the right
  {
    this.element.style.left = this.pivotX + "px";
    this.element.style.width = (parent_width - this.pivotX - 2*this.elementBorderWidth) +"px";
  }
  else
  {
    if (tempx < this.pivotX)  // The mouse is to the left of the first point that was clicked
    {
      if (tempx < 0) // If the mouse is outside the container on the left
      {
        this.element.style.left = "0px";
        this.element.style.width = this.pivotX+"px";
      }
      else
      {
        this.element.style.width = (this.pivotX - tempx) +"px";
        var xpos = tempx;
        this.element.style.left = xpos + "px";
      } 
    }
    else  // If mouse x coordinate is to the right of the first point that was clicked
    {
      var xpos = this.pivotX;
      this.element.style.left = xpos + "px";
      this.element.style.width = (tempx-this.pivotX) +"px";
    }
  }

  if (tempy > parent_height)
  {
    this.element.style.top = this.pivotY + "px";
    this.element.style.height = (parent_height - this.pivotY - 2*this.elementBorderWidth) +"px";
  }
  else
  {
     // If we are dragging above the pivot point
     if (tempy < this.pivotY)
    {
      if (tempy < 0)
      {
        this.element.style.top = "0px";
        this.element.style.height = this.pivotY+"px";
      }
      else
      {
        this.element.style.height = (this.pivotY - tempy) +"px";
        var ypos = tempy;
        this.element.style.top = ypos + "px";
      }
    }
    // If we are dragging below the pivot point
    else
    {
      var ypos = this.pivotY;
      this.element.style.top = ypos + "px";
      this.element.style.height = (tempy-this.pivotY) +"px";
    }
  }

} 

Tagger.prototype.mouseUp = function(event) { 
  // Set the form elements
  this.isMouseDown = false;
  var x_coordElement = document.getElementById(this.x_coordID);
  var y_coordElemeent =  document.getElementById(this.y_coordID);
  var widthElement =  document.getElementById(this.widthID);
  var heightElement =  document.getElementById(this.heightID);
  x_coordElement.value = this.element.offsetLeft;
  y_coordElemeent.value = this.element.offsetTop;
  widthElement.value = this.element.offsetWidth;
  heightElement.value = this.element.offsetHeight;

  document.onmousemove = this.oldMoveHandler; 
  document.onmouseup = this.oldUpHandler; 
}
