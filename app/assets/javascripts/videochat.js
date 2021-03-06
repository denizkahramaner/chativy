
	TB.addEventListener("exception", exceptionHandler);
	var session = TB.initSession("2_MX4yMzI4MDY5Mn4xMjcuMC4wLjF-V2VkIE1hciAyMCAxNDo1Mzo0OCBQRFQgMjAxM34wLjQzMTQ1MTU2fg"); // Replace with your own session ID. See https://dashboard.tokbox.com/projects
	session.addEventListener("sessionConnected", sessionConnectedHandler);
	session.addEventListener("streamCreated", streamCreatedHandler);
	session.connect("23280692", "T1==cGFydG5lcl9pZD0yMzI4MDY5MiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz1jMjU0YzMxNzJhZjE1MTZlNTQxMDJkMDg4YmVmZTExZjYwOWY4NWYzOnJvbGU9cHVibGlzaGVyJnNlc3Npb25faWQ9Ml9NWDR5TXpJNE1EWTVNbjR4TWpjdU1DNHdMakYtVjJWa0lFMWhjaUF5TUNBeE5EbzFNem8wT0NCUVJGUWdNakF4TTM0d0xqUXpNVFExTVRVMmZnJmNyZWF0ZV90aW1lPTEzNjM4MTY0Mzgmbm9uY2U9MC4zNDM3MDM5NzU4MzIzNTM0NiZleHBpcmVfdGltZT0xMzYzOTAyODM4JmNvbm5lY3Rpb25fZGF0YT0="); // Replace with your API key and token. See https://dashboard.tokbox.com/projects
	                                         // 	 and https://dascts

	function sessionConnectedHandler(event) {
		 subscribeToStreams(event.streams);
		 session.publish();
	}
	
	function streamCreatedHandler(event) {
		subscribeToStreams(event.streams);
	}
	
	function subscribeToStreams(streams) {
		for (i = 0; i < streams.length; i++) {
			var stream = streams[i];
			if (stream.connection.connectionId != session.connection.connectionId) {
				session.subscribe(stream);
			}
		}
	}
	
	function exceptionHandler(event) {
		alert("Exception: " + event.code + "::" + event.message);
	}
	