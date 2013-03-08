
function AjaxHandler(callback){
	this.callback = callback;
	this.xmlhttp = null;
	var self = this;
	if (window.XMLHttpRequest) {
		this.xmlhttp=new XMLHttpRequest();	
		this.xmlhttp.onreadystatechange = function()
		{
			self.onReadyStateChange();
		}
	}
}

AjaxHandler.prototype.sendURL = function(url) {
	this.requestURL= url;
	this.xmlhttp.open("GET",this.requestURL,true);
	this.xmlhttp.send();
}

AjaxHandler.prototype.onReadyStateChange = function() {
	if (this.xmlhttp.readyState==4 && this.xmlhttp.status==200)  {
		this.callback(this.xmlhttp.responseText);
	}
}


