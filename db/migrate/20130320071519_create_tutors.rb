class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
	 	t.column :id, 			:integer
		t.column :first_name, 	:string
	 	t.column :last_name , 	:string
	 	t.column :school, 		:string
	 	t.column :sat_score,	:integer
	 	t.column :description,	:text
	 	t.timestamps
	 	t.column :password_digest, :string
	    t.column :salt, :string
	    t.column :login, :string
    end
  end
end
