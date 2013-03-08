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
		elsif User.exists?(:login => loginString) then
			user = User.find_by_login(loginString)
			if user.password_valid?(inputPassword)
				session[:user] = user.id
				redirect_to :controller => "pics", :action => "user", :id => user.id
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
			@user = User.new
		end
	end

	def post_register
		@title = "Registration Form"
		@user = User.new(params[:user])
		@user.password = params[:user][:password]
		if @user.save()
			session[:user] = @user.id
			redirect_to :controller => "pics", :action => "users"
		elsif
			render :controller => "user", :action => "register"
		end
	end
end