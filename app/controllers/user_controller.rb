class UserController < ApplicationController
	def login
		@title = "Login or Register for a New Account"
	end

	def post_login
		loginString = params[:user][:login]
		inputPassword = params[:user][:password]
		flash[:notice] =[]
		if loginString.length == 0 
			flash[:notice] << "Login can't be blank"
		end
		if inputPassword.length == 0
			flash[:notice] << "Password can't be blank"
		elsif Student.exists?(:login => loginString) then
			student_user = Student.find_by_login(loginString)
			if student_user.password_valid?(inputPassword)
				session[:user] = student_user.id
				session[:user_type] = "student"
				redirect_to :controller => "student", :action => "dashboard"
				return
			end
		elsif Tutor.exists?(:login => loginString) then
			tutor = Tutor.find_by_login(loginString)
			if tutor.password_valid?(inputPassword)
				session[:user] = tutor.id
				session[:user_type] = "tutor"
				redirect_to :controller => "tutor", :action => "dashboard"
				return
			end
		end
		flash[:notice] << "Invalid login name or password, please enter again"
		redirect_to :controller => "user", :action => "login" 
	end

	def logout
 		reset_session
		redirect_to :controller => "user", :action => "login"
	end

	def register
		@title = "Registration Form"
		if @user.nil?
			@user = Student.new
		end
	end

	def register_tutor
		@title = "Tutor Application Form"
		if @user.nil?
			@user = Tutor.new
		end
	end

	def post_register
		@title = "Registration Form"
		@user = Student.new(params[:student])
		@user.password = params[:student][:password]
		if @user.save()
			session[:user] = @user.id
			session[:user_type] = "student"
			redirect_to :controller => "student", :action => "dashboard"
		elsif
			render :controller => "user", :action => "register"
		end
	end

	def post_register_tutor
		@title = "Registration Form"
		@user = Tutor.new(params[:tutor])
		@user.password = params[:tutor][:password]
		if @user.save()
			session[:user] = @user.id
			session[:user_type] = "tutor"
			redirect_to :controller => "tutor", :action => "dashboard"
		elsif
			render :controller => "user", :action => "register_tutor"
		end
	end
	
end
