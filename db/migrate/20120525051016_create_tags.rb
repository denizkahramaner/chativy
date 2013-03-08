class CreateTags < ActiveRecord::Migration
	def up
		create_table :tags do |t|
		 	t.column :id, 			:integer
			t.column :user_id, 		:integer
		 	t.column :photo_id, 	:integer
		 	t.column :x_coord,		:integer
		 	t.column :y_coord, 		:integer
		 	t.column :width, 		:integer
		 	t.column :height, 		:integer
	 	end
	end
	 
	def down
		drop_table :tags
	end
end
