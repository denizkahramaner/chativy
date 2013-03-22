class VideoChat < ActiveRecord::Base
    has_one :student
  	has_many :tutors
end
