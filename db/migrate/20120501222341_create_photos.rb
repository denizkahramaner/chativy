class CreatePhotos < ActiveRecord::Migration
	def up
		create_table :photos do |t|
			t.column :id, 			:integer
			t.column :user_id, 		:integer
		 	t.column :date_time , 	:datetime
		 	t.column :file_name, 	:url
		end
	end
    
	def down
		drop_table :photos
	end
end
