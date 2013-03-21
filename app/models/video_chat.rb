class VideoChat < ActiveRecord::Base
    has_one :student
  	has_one :tutor
end
