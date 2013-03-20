class CreateStudents < ActiveRecord::Migration
  	def up
		create_table :students do |t|
		 	t.column :id, 			:integer
			t.column :first_name, 	:string
		 	t.column :last_name , 	:string
		 	t.column :school, 		:string
		 	t.timestamps
	 	end
	end

	def down
		drop_table :students
	end
end