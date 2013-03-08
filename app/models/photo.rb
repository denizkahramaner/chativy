class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :tags

	validates :file_name, :presence => true

	# Returns date and time in Pacific time zone
	def date_pacific
		return self.date_time.in_time_zone("Pacific Time (US & Canada)")
	end

	def self.filter(word) 
		downcase_word = "%" + word.to_s.downcase + "%"
		result_photos = Array.new
		if(word == nil)
			return Photo.all
		end
		# I use active record to get the result photos instead of iterating over all the photos
		result_photos = Photo.includes(:comments, :tags => :user).where("lower(users.first_name) LIKE ? OR lower(users.last_name) LIKE ? OR lower(comments.comment) LIKE ?", downcase_word, downcase_word, downcase_word).uniq
		return result_photos
	end
end
