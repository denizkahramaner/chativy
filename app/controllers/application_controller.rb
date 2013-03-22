class ApplicationController < ActionController::Base
  	protect_from_forgery
  	before_filter :check_logged_in

	def check_logged_in
		if session[:user] then
			@logged_in_user = User.find(session[:user])
			@user_is_tutor = session[:user_type] == "tutor"
			@user_is_student = session[:user_type] == "student"
		end
	end


	def redirect_if_not_logged_in
		if !@logged_in_user then
			redirect_to :controller => "user", :action => "login"
		end
	end
end
