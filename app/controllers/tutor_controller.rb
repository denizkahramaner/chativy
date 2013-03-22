class TutorController < ApplicationController
	def dashboard
		@videochats = VideoChat.find(:all, :order => "date")
	end
end
