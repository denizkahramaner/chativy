class ApplicationController < ActionController::Base
  	protect_from_forgery
  	before_filter :check_logged_in

	def check_logged_in
		if session[:user] then
			@logged_in_user = User.find(session[:user])
		end
	end


	def redirect_if_not_logged_in
		if !@logged_in_user then
			redirect_to :controller => "user", :action => "login"
		end
	end

	def user_is_tutor
		if session[:user_type] == "tutor"
		end
	end
end
