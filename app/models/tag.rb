class Tag < ActiveRecord::Base
	belongs_to :photo
  	belongs_to :user

  	validates :x_coord, :presence => true
  	validates :y_coord, :presence => true
  	validates :width, :presence => true
  	validates :height, :presence => true
end
