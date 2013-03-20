class PicsController < ApplicationController 
	before_filter :redirect_if_not_logged_in, :except=>[:user, :users, :search]
	helper_method :find_comment
	respond_to :html, :js

	def users
		@tutors = Tutor.find(:all)
	end

	def search
		@substr = params[:substring]
     	@result_photos = Photo.filter(@substr) 
        respond_to do |elem|
        	elem.html do render :layout => false, :partial =>"list_photos"
        	end
        	elem.js do render :text => @result_photos.to_json
        	end
        end
	end
    
	def user
		user_id = params[:id]
		@user = User.find_by_id(user_id)
		@own_page = false
		if session[:user].to_i == user_id.to_i then
			@own_page = true
		end

		if @user
			@user_name =@user.first_name+" "+@user.last_name	
			if @own_page then
				@title = "Your Profile"
			else 
				@title = @user_name + "'s Profile"
			end
		else
			@title = "User not found"	
		end
	end

	def tag
		@users = User.find(:all)
		@title = "Tag"
		@photo = Photo.find_by_id(params[:id])
		if @tag.nil?
			@tag = Tag.new
		end
	end

	def post_tag
			@users = User.find(:all)
			@photo = Photo.find_by_id(params[:id])
			@title = "Tag"
			@tag = Tag.new(params[:tag])
			@tag.photo_id = params[:id]
			if @tag.save() then
				redirect_to :controller => "pics", :action => "user", :id => @photo.user_id
			else
				flash[:notice] = "You didn't tag anyone! "
				render :controller => "pics", :action => "tag", :id => params[:id]
			end
	end

	def comment
		@title = "Comment Form"
		@photo = Photo.find_by_id(params[:id])
		if @comment.nil?
			@comment = Comment.new
		end
	end

	def post_comment
		@title = "Comment Form"
		@photo = Photo.find(params[:id])
		@comment = Comment.new(params[:comment])
		@comment.user_id = session[:user]
		@comment.photo_id = params[:id]
		@comment.date_time = DateTime.now()
		user_of_photo = Photo.find_by_id(params[:id]).user_id
		puts "USER OF PHOTO!!!!!!!!!!!      ::::" +user_of_photo.to_s
		if @comment.valid?
			puts "valid comment"
		else
			puts "invalid comment"
		end
		if @comment.save() then
			redirect_to :controller => "pics", :action => "user", :id => user_of_photo
		else
			render :controller => "pics", :action => "comment", :id => params[:id]
		end
	end

	def photo
		@title = "Photo upload page"
	end

	def post_photo
		@title = "Photo upload page"
		if !params.has_key?(:pics) then
			flash[:notice] = "Blank file. Please pick a proper picture file."
			render :controller => "pics", :action => "photo"
			return
		end
		joined_directory = File.join("public/images/", params[:pics][:image].original_filename)
		photo_file = File.new(joined_directory,"wb")
		photo_file.write(params[:pics][:image].read)
		photo = Photo.new
		photo.user_id = session[:user]
		photo.date_time = DateTime.now()
		photo.file_name = params[:pics][:image].original_filename
		if photo.save() then
			redirect_to :controller => "pics", :action => "user", :id => session[:user]
		elsif
			render :controller => "pics", :action => "photo"
		end	
	end



end

