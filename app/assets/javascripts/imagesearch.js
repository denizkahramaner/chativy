
function ImageSearch(search_field, url, user_url, target){
	var self = this;
	this.ajax_handler = new AjaxHandler(function(responseText)
	{
		self.setResponseText(responseText);
	});
	this.user_url = user_url; 
	this.search_field = document.getElementById(search_field);
	this.search_field.value ="";
	this.url = url;
	this.target = document.getElementById(target);
	this.user_input = this.search_field.value;
	this.search_field.onkeyup = function(event)
	{
		self.onKeyUp(event);
	}	
}

ImageSearch.prototype.onKeyUp = function(event) {
	window.console.log("On key up");
    this.user_input = encodeURIComponent(this.search_field.value);
	if (this.user_input.length==0)  { 
		this.target.innerHTML="";
		return;
	}
	this.requestURL= this.url+"="+this.user_input ;
	this.ajax_handler.sendURL(this.requestURL);
}

ImageSearch.prototype.setResponseText = function(responseText)
{
	var arrayOfPhotos=JSON.parse(responseText);
	var imageList = this.createImageList(arrayOfPhotos);
	this.target.appendChild(imageList);
}


// Takes a JSON array of objects which represent photos and returns a list of images in DOM
ImageSearch.prototype.createImageList = function (arrayOfPhotos) {
	this.target.innerHTML = "";
	var wrapperDiv = document.createElement("DIV");
	wrapperDiv.className = "photo_results";
	if (arrayOfPhotos.length > 0)
	{
		for (var i=0; i<arrayOfPhotos.length; i++)
		{
			var currentPhoto = arrayOfPhotos[i];
			var link = document.createElement("A");
			link.href = this.user_url + "/"+ currentPhoto.user_id.toString() + "#" + currentPhoto.id.toString();
			var image = document.createElement("IMG");
			image.src = "/images/" + currentPhoto.file_name;
			image.className = "user_pic search_result";
			image.alt = "";
			link.appendChild(image);
			wrapperDiv.appendChild(link);
		}
	}
	else
	{
		var errorMessage = document.createElement("P");
		var errorText = document.createTextNode("We couldn't find a photo. You should search for a part of comments on a picture or a tagged user's first or last name");
		wrapperDiv.appendChild(errorText);
	}
	return wrapperDiv;
}

