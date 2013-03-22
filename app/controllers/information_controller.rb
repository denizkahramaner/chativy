class InformationController < ApplicationController
	def index
		@logged_in_user = User.find(session[:user])
		@user_is_tutor = session[:user_type] == "tutor"
		@user_is_student = session[:user_type] == "student"

		if @logged_in_user && @user_is_tutor
			redirect_to :controller => "tutor", :action => "dashboard"
		elsif @logged_in_user && @user_is_student
			redirect_to :controller => "student", :action => "dashboard"
		end
	end
end
