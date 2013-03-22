class StudentController < ApplicationController

	API_KEY = '23280692'                # should be a string
	API_SECRET = '4538f94d94b949ec18efe9bc0b2e131fb1295829'
	OTSDK = OpenTok::OpenTokSDK.new API_KEY, API_SECRET
	THIRTY_DAYS = 2592000#thirty days (max expiration date) in seconds 
	def conference
		# Creating Session object with p2p enabled
		sessionProperties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}    # or disabled
		@sessionID = OTSDK.createSession( request.ip, sessionProperties )
		expire_time = Time.now.to_i + THIRTY_DAYS
		@token = OTSDK.generateToken :session_id => @sessionID, :role => OpenTok::RoleConstants::PUBLISHER, :expire_time => expire_time
		@apiKey = API_KEY
	end

	def generateSession
		sessionProperties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}    # or disabled
		sessionID = OTSDK.createSession( request.ip, sessionProperties )
		expire_time = Time.now.to_i + THIRTY_DAYS
		token = OTSDK.generateToken :session_id => sessionID, :role => OpenTok::RoleConstants::PUBLISHER, :expire_time => expire_time
		return sessionID, token
	end

	def reserve
		@title = "Reservation form"
	end

	def post_reserve
		reservationTime = params[:reservationTime]
		#parse reservation time
		
		sessionID,token = generateSession()
		#save to database
		@conference_session = VideoChat.new(:date => DateTime.now(), :session_id => sessionID, :session_token => token )
		@conference_session.student_id = session[:user]

		if @conference_session.save()
			redirect_to :controller => "student", :action => "dashboard"
		elsif
			render :controller => "student", :action => "reserve"
		end
	end


	def dashboard
		@videochats = VideoChat.find_all_by_student_id(session[:user], :order => "date")
		if session[:user] then
			@student = Student.find(session[:user])
		end
	end

end
