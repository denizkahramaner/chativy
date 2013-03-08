class CreateComments < ActiveRecord::Migration
	def up
		create_table :comments do |t|
			t.column :id, 			:integer
			t.column :photo_id, 	:integer
		 	t.column :user_id, 		:integer
		 	t.column :date_time, 	:datetime
		 	t.column :comment,		:string
		end
	end
    
	def down
		drop_table :comments
	end
end
