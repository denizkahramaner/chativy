class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo

	validates :comment, :presence => true

	# Returns date and time in Pacific Time zone
	def date_pacific
		return self.date_time.in_time_zone("Pacific Time (US & Canada)")
	end


end
